class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_index :users, :full_name, :name => 'full_name_index'
  end
end
