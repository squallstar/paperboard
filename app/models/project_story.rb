class ProjectStory < ActiveRecord::Base
  belongs_to :project, touch: true
  belongs_to :owner, class_name: :User

  validates :project, null: false
  validates :owner, null: false
  validates :title, presence: true
end