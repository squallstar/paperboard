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
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :memberships, foreign_key: :user_id, class_name: :ProjectMember, dependent: :destroy
  has_many :projects, through: :memberships

  has_many :organization_memberships, foreign_key: :user_id, class_name: :OrganizationMember, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  has_many :sent_invites, :class_name => 'Invites', :foreign_key => 'sender_id'
  has_many :accepted_invites, :class_name => 'Invites', :foreign_key => 'user_id'

  def to_param
    "#{id}-#{full_name}"
  end

  def colleagues
    User.where(id:
      ProjectMember.select(:user_id).where(project_id:
        ProjectMember.select(:project_id).where(user: self)
      )
    ).where('id != ?', self.id)
  end

  def update_with_password(user_params)
    current_password = user_params.delete(:current_password)

    if self.authenticate(current_password)
      self.update(user_params)
      true
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end
  end

  private
    def before_save
      self.full_name = first_name + ' ' + last_name
    end
end