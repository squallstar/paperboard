# == Schema Information
#
# Table name: project_members
#
#  id         :integer          not null, primary key
#  role       :string(255)
#  project_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

#
# SCHEMA:
# role
# project_id
# user_id
#

class ProjectMember < ActiveRecord::Base
  belongs_to :project, touch: true, counter_cache: :members_count
  belongs_to :user, touch: true

  validates :project, null: false
  validates :user, null: false
  validates_inclusion_of :role, :in => %w(owner member)
  validates_uniqueness_of :project_id, scope: :user_id
end
