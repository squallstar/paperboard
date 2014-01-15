#
# Database Schema for User class
#
# string   "username"
# string   "first_name"
# string   "last_name"
# string   "email"
# string   "password_digest"
# datetime "created_at"
# datetime "updated_at"
# boolean  "is_active"
# boolean  "email_verified"

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy
  has_many :projects, through: :memberships

  def full_name
    first_name + ' ' + last_name
  end
end