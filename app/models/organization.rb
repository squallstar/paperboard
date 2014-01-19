class Organization < ActiveRecord::Base
  has_many :users, through: :organization_members
  has_many :members, foreign_key: :organization_id, class_name: :OrganizationMember, dependent: :destroy
  has_many :teams, dependent: :destroy

  validates :name, null: false, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
