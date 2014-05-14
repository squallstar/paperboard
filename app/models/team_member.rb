# == Schema Information
#
# Table name: team_members
#
#  id         :integer          not null, primary key
#  role       :string(255)
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

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
  validates_inclusion_of :role, in: %w(admin member)
  validates_uniqueness_of :team_id, scope: :user_id

  validates_uniqueness_of :team_id,
                          scope: [:user_id],
                          message: 'has already been used to invite the user onboard'
end
