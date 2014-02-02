class AddOrganizationToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :organization, index: true
    add_column :projects, :owner_id, :integer, index: true

    create_table :project_teams do |t|
      t.references :project, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
