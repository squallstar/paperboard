# == Schema Information
#
# Table name: project_teams
#
#  id         :integer          not null, primary key
#  project_id :integer
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProjectTeam < ActiveRecord::Base
  belongs_to :project, touch: true
  belongs_to :team

  validates :project, null: false
  validates :team, null: false

  validates_uniqueness_of :project_id, scope: :team_id
end
