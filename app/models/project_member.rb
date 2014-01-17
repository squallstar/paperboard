#
# SCHEMA:
# role
# project_id
# user_id
#

class ProjectMember < ActiveRecord::Base
  belongs_to :project, touch: true, counter_cache: :members_count
  belongs_to :user

  validates :project, null: false
  validates :user, null: false
  validates_inclusion_of :role, :in => %w(owner member)
  validates_uniqueness_of :project_id, scope: :user_id
end