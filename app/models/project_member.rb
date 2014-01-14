#
# SCHEMA:
# role
# project_id
# user_id
#

class ProjectMember < ActiveRecord::Base
  belongs_to :project, touch: true, counter_cache: :members_count
  belongs_to :user

  validates_inclusion_of :role, :in => %w(owner member)
  validates :project, null: false
  validates :user, null: false
end