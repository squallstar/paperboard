class ProjectInvite < ActiveRecord::Base
  validates :accepted, :default => false
  validates :email, :presence => true
  validates :sender, :presence => true
  validates_uniqueness_of :email,
    scope: [:project_id, :user_id],
    message: "has already been used to invite a user on this project"

  before_create :set_defaults

  belongs_to :project, touch: true
  belongs_to :user, class_name: :User
  belongs_to :sender, class_name: :User

  def accept_with_user(user)
    self.accepted = true
    self.user = user
    save!

    project.members.create role: 'member', user: user
  end

  private
    def set_defaults
      self.accepted = false

      require 'securerandom'
      self.key = SecureRandom.uuid
    end
end