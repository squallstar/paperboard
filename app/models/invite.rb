class Invite < ActiveRecord::Base
  validates :accepted, :default => false
  validates :email, :presence => true

  belongs_to :project
  belongs_to :user
end
