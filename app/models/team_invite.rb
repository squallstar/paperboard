class TeamInvite < ActiveRecord::Base
  include Email
  validates :accepted, :default => false
  validates :sender, :presence => true

  validates_uniqueness_of :email,
    scope: [:team_id, :user_id],
    message: "has already been used to invite a user on this project"

  belongs_to :user, class_name: :User
  belongs_to :team, touch: true
  belongs_to :sender, class_name: :User
  belongs_to :team

  before_create :set_defaults

  def accept_with_user(user)
    self.accepted = true
    self.user = user
    save!

    team.members.create role: 'member', user: user
  end

  private
    def set_defaults
      self.accepted = false

      require 'securerandom'
      self.key = SecureRandom.uuid
    end
end