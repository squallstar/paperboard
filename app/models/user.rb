#
# Database Schema for User class
#
# string   "username"
# string   "first_name"
# string   "last_name"
# string   "full_name"
# string   "email"
# string   "password_digest"
# datetime "created_at"
# datetime "updated_at"
# boolean  "is_active"
# boolean  "email_verified"

class User < ActiveRecord::Base
  before_save :before_save
  after_update :after_change
  after_destroy :after_destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { :within => 6..40 }, if: :should_validate_password?

  has_secure_password
  attr_accessor :updating_password
  attr_accessor :current_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :organization_memberships, foreign_key: :user_id, class_name: :OrganizationMember, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  has_many :sent_invites, :class_name => 'Invites', :foreign_key => 'sender_id'
  has_many :accepted_invites, :class_name => 'Invites', :foreign_key => 'user_id'

  has_one :subscription

  has_attached_file :avatar, styles: {
    small: ['80x80#', :png],
    medium: '200x200#'
  }

  validates_attachment_size :avatar, less_than: 1.megabyte
  validates_attachment :avatar,
    content_type: { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] }

  def to_param
    "#{id}-#{full_name.parameterize}"
  end

  def colleagues
    User.where(id:
      OrganizationMember.select(:user_id).where(organization_id:
        OrganizationMember.select(:organization_id).where(user: self)
      )
    ).where('id != ?', self.id)
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
      if self.client_id
        @client = Paymill::Client.find(self.client_id)
      else
        @client = Paymill::Client.create paymill_attributes
        self.client_id = @client.id
        save!
      end
    end
    @client
  end

  private
    def should_validate_password?
      updating_password || new_record?
    end

    # Updates the full_name before saving
    def before_save
      self.full_name = first_name + ' ' + last_name
    end

    # Updates the Paymill client whenever the full_name or email have changed
    def after_change
      if self.email_changed? or self.full_name_changed?
        client.update_attributes paymill_attributes
      end
    end

    def after_destroy
      if self.client_id
        Paymill::Client.delete(self.client_id)
      end
    end

    # Attributes for Paymill client
    def paymill_attributes
      {email: email, description: full_name}
    end
end