class StoryComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story, foreign_key: :project_story_id, class_name: :ProjectStory, counter_cache: :comments_count

  validates :user, presence: true
  validates :story, presence: true
end
