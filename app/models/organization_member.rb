class OrganizationMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :organization, null: false
  validates :user, null: false
  validates_inclusion_of :role, :in => %w(owner member)
  validates_uniqueness_of :organization_id, scope: :user_id
end
