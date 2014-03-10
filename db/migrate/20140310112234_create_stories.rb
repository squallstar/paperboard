class CreateStories < ActiveRecord::Migration
  def change
    create_table :project_stories do |t|
      t.string :title
      t.text :body
      t.boolean :closed
      t.references :project, index: true
      t.references :owner, index: true

      t.timestamps
    end
  end
end
