#
# SCHEMA:
# role
# team_id
# user_id
#

class TeamMember < ActiveRecord::Base
  belongs_to :team, counter_cache: :members_count
  belongs_to :user, touch: true

  validates :team, null: false
  validates :user, null: false
  validates_inclusion_of :role, :in => %w(admin member)
  validates_uniqueness_of :team_id, scope: :user_id
end