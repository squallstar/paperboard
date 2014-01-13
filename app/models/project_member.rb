#
# SCHEMA:
# role
# project_id
# user_id
#

class ProjectMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_inclusion_of :role, :in => %w(owner member)
  validates :project, presence: true
  validates :user, presence: true, null: false
end