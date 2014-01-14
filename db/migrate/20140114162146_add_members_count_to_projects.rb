class AddMembersCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :members_count, :integer, :default => 0
  end
end