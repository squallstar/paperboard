class Invite < ActiveRecord::Base
  validates :accepted, :default => false
  validates :email, :presence => true
  validates :sender, :presence => true
  validates_uniqueness_of :email, scope: [:project_id, :user_id]

  before_create :set_defaults

  belongs_to :project
  belongs_to :user, class_name: :User
  belongs_to :sender, class_name: :User

  private
    def set_defaults
      self.accepted = false

      require 'securerandom'
      self.key = SecureRandom.uuid
    end
end