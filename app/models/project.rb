class Project < ActiveRecord::Base
  has_many :users, through: :project_members
  has_many :project_members

  validates :project_members, :length => { :minimum => 1 }
end