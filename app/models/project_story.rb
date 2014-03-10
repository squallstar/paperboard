# == Schema Information
#
# Table name: project_stories
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  closed         :boolean
#  project_id     :integer
#  owner_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  assigned_to_id :integer
#  priority       :integer
#  due_at         :datetime
#

class ProjectStory < ActiveRecord::Base
  belongs_to :project, touch: true
  belongs_to :owner, class_name: :User

  has_one :assigned_to, class_name: :User

  validates :project, null: false
  validates :owner, null: false
  validates :title, presence: true
  validates :priority, :inclusion => { :in => 0..4, :message => "The priority must be between 0 and 4" }
end
