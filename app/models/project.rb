class Project < ActiveRecord::Base
  has_many :users, through: :project_members
  has_one :organization
  has_many :members, foreign_key: :project_id, class_name: :ProjectMember, dependent: :destroy
  has_many :invites, foreign_key: :project_id, class_name: :ProjectInvite, dependent: :destroy
  has_many :teams, foreign_key: :team_id, class_name: :ProjectTeam, dependent: :destroy

  validates :name, null: false, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end