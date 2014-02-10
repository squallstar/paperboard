class Team < ActiveRecord::Base
  belongs_to :organization
  validates_inclusion_of :role, :in => %w(admin standard)
  has_many :members, foreign_key: :team_id, class_name: :TeamMember, dependent: :destroy

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def is_admin?
    role == 'admin'
  end

  def can_be_deleted?
    role != 'admin' && name != 'Owners'
  end
end
