class Team < ActiveRecord::Base
  belongs_to :organization
  has_many :members, foreign_key: :team_id, class_name: :TeamMember, dependent: :destroy

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
