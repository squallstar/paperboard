class Organization < ActiveRecord::Base
  include Subscriptions

  has_many :teams, dependent: :destroy
  has_many :members, through: :teams
  has_many :users, -> { uniq } , through: :members
  has_many :projects, dependent: :destroy

  after_create :create_default_teams

  class_attribute :creator

  validates :name, null: false, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.new_with_user(params, user)
    self.creator = user
    self.new params
  end

  def remove_user(user)
    user.team_memberships.where(team_id: teams).destroy_all

    if members.count == 0
      destroy
    end
  end

  private
    def create_default_teams
      team = Team.create! name: 'Owners', role: 'owner', organization: self
      team.members.create! role: 'admin', user: self.creator
    end
end
