#
# Database Schema for User class
#
# string   "first_name"
# string   "last_name"
# string   "full_name"
# string   "email"
# string   "password_digest"
# datetime "created_at"
# datetime "updated_at"
# boolean  "is_active"
# boolean  "email_verified"
# string   "request_token"

class User < ActiveRecord::Base
  include Email
  include Subscriptions

  before_save :before_save
  after_update :after_change
  after_destroy :after_destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { :within => 6..40 }, if: :should_validate_password?

  has_secure_password
  attr_accessor :updating_password
  attr_accessor :current_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :team_memberships, foreign_key: :user_id, class_name: :TeamMember, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :organizations, -> { uniq }, through: :teams

  has_many :sent_invites, :class_name => :ProjectInvite, :foreign_key => 'sender_id'
  has_many :accepted_invites, :class_name => :ProjectInvite, :foreign_key => 'user_id'

  has_many :sent_team_invites, :class_name => :TeamInvite, :foreign_key => 'sender_id'
  has_many :accepted_team_invites, :class_name => :TeamInvite, :foreign_key => 'user_id'

  has_attached_file :avatar, styles: {
    small: ['80x80#', :png],
    medium: '200x200#'
  }, default_url: lambda { |avatar| avatar.instance.set_avatar_default_url}

  validates_attachment_size :avatar, less_than: 1.megabyte, message: " should be less than 1Mb"
  validates_attachment :avatar,
    content_type: { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] }

  scope :where_name_like, -> (query) do
    where("lower(last_name) LIKE :query OR lower(full_name) LIKE :query OR lower(email) LIKE :query", query: query)
  end

  def to_param
    "#{id}-#{full_name.parameterize}"
  end

  def colleagues
    User.where(id:
      TeamMember.select(:user_id).where(team_id: cached_teams)
    )
  end

  def siblings
    User.where(id:
      ProjectMember.select(:user_id).where(project_id:
        ProjectMember.select(:project_id).where(user: self)
      )
    ).where('id != ?', self.id)
  end

  def update_with_password(user_params)
    updating_password = true
    current_password = user_params.delete(:current_password)

    if self.authenticate(current_password)
      self.update(user_params)
      true
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :match)
      false
    end
  end

  # Gets the paymill associated client
  def client
    if not @client
      if client_id
        @client = Paperboard::Payments.find_client client_id
      else
        @client = Paperboard::Payments.create_client payment_client_attributes
        client_id = @client.id
        save!
      end
    end
    @client
  end

  def has_active_subscription
    subscription and subscription.active
  end

  # Key to be used in the registration email
  def optin_key
    require 'digest/md5'
    Digest::MD5.hexdigest("#{id}#{email}")
  end

  def generate_request_token
    require 'digest/md5'
    self.request_token = Digest::MD5.hexdigest("#{email}#{Time.now}")
    save!
    self.request_token
  end

  def join_pending_invites
    ProjectInvite.where(email: self.email, accepted: false).find_each do |invite|
      invite.accept_with_user(self)
    end
    TeamInvite.where(email: self.email, accepted: false).find_each do |invite|
      invite.accept_with_user(self)
    end
  end

  def set_avatar_default_url
    ActionController::Base.helpers.asset_path('avatar.png')
  end

  def cached_organizations
    Rails.cache.fetch ["organizations", self] do
      self.organizations.to_a
    end
  end

  def cached_teams
    Rails.cache.fetch ["teams", self] do
      self.teams.to_a
    end
  end

  private
    def should_validate_password?
      updating_password || new_record?
    end

    # Updates the full_name before saving
    def before_save
      self.full_name = first_name + ' ' + last_name
    end

    # Updates the Payments client whenever the full_name or email have changed
    def after_change
      if self.email_changed? or self.full_name_changed?
        Paperboard::Payments.update_client client, payment_client_attributes
      end
    end

    def after_destroy
      if client_id
        Paperboard::Payments.delete_client client_id
      end
    end

    # Attributes for Payments client
    def payment_client_attributes
      {email: email, description: full_name}
    end
end