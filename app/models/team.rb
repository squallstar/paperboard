# == Schema Information
#
# Table name: teams
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  organization_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#  members_count   :integer          default(0)
#  role            :string(255)
#

class Team < ActiveRecord::Base
  belongs_to :organization
  validates_inclusion_of :role, :in => %w(owner admin standard)

  has_many :members, foreign_key: :team_id, class_name: :TeamMember, dependent: :destroy
  has_many :invites, foreign_key: :team_id, class_name: :TeamInvite, dependent: :destroy

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def is_admin?
    role == 'owner' || role == 'admin'
  end

  def can_be_deleted?
    role != 'owner'
  end
end
