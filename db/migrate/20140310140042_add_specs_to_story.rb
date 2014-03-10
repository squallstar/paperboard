class AddSpecsToStory < ActiveRecord::Migration
  def change
    add_reference :project_stories, :assigned_to, index: true
    add_column :project_stories, :priority, :integer, default: 0
    add_column :project_stories, :due_at, :timestamp
  end
end