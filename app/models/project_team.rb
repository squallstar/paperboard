class ProjectTeam < ActiveRecord::Base
  belongs_to :project, touch: true
  belongs_to :team

  validates :project, null: false
  validates :team, null: false

  validates_uniqueness_of :project_id, scope: :team_id
end