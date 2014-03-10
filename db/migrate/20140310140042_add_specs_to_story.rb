class AddSpecsToStory < ActiveRecord::Migration
  def change
    add_reference :project_stories, :assigned_to, index: true
    add_column :project_stories, :priority, :integer
    add_column :project_stories, :due_at, :timestamp
  end
end