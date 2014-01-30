class AddRoleToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :role, :string, index: true
  end
end
