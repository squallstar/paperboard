class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy

  def projects
    memberships.includes(:project)
  end

  def project_with_id(project_id)
    Project.where(id: project_id).joins(:members).where(project_members: {user_id: id}).limit(1).first
  end
end