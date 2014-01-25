#
# SCHEMA:
# role
# team_id
# user_id
#

class TeamMember < ActiveRecord::Base
  belongs_to :team, touch: true, counter_cache: :members_count
  belongs_to :user

  validates :team, null: false
  validates :user, null: false
  validates_inclusion_of :role, :in => %w(admin member)
  validates_uniqueness_of :team_id, scope: :user_id
end