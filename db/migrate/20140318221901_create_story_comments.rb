class CreateStoryComments < ActiveRecord::Migration
  def change
    create_table :story_comments do |t|
      t.references :user, index: true
      t.references :project_story, index: true
      t.string :body

      t.timestamps
    end

    add_column :project_stories, :comments_count, :integer, :default => 0
  end
end
