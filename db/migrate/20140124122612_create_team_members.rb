class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :role
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end

    add_column :teams, :members_count, :integer, :default => 0
  end
end
