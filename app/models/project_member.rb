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
end