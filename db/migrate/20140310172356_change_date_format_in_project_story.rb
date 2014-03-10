class ChangeDateFormatInProjectStory < ActiveRecord::Migration
  def change
    change_column :project_stories, :due_at, :date
  end
end
