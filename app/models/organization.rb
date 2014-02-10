class Organization < ActiveRecord::Base
  has_many :teams, dependent: :destroy

  has_many :members, through: :teams
  has_many :users, -> { uniq } , through: :members

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

  private
    def create_default_teams
      team = Team.create! name: 'Owners', role: 'admin', organization: self
      team.members.create! role: 'admin', user: self.creator
    end
end
