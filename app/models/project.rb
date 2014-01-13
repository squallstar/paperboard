class Project < ActiveRecord::Base
  has_many :users, through: :project_members
  has_many :members, foreign_key: :project_id, class_name: :ProjectMember, dependent: :destroy
  
  validates :name, presence: true
end
