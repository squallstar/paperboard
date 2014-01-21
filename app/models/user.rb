#
# Database Schema for User class
#
# string   "username"
# string   "first_name"
# string   "last_name"
# string   "full_name"
# string   "email"
# string   "password_digest"
# datetime "created_at"
# datetime "updated_at"
# boolean  "is_active"
# boolean  "email_verified"

class User < ActiveRecord::Base
  before_save :before_save
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :organization_memberships, foreign_key: :user_id, class_name: :OrganizationMember, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  has_many :sent_invites, :class_name => 'Invites', :foreign_key => 'sender_id'
  has_many :accepted_invites, :class_name => 'Invites', :foreign_key => 'user_id'

  def to_param
    "#{username}"
  end

  def colleagues
    User.where(id:
      ProjectMember.select(:user_id).where(project_id:
        ProjectMember.select(:project_id).where(user: self)
      )
    ).where('id != ?', self.id)
  end

  private
    def before_save
      self.full_name = first_name + ' ' + last_name
    end
end