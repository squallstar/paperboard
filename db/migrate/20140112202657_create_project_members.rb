class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.string :role
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
