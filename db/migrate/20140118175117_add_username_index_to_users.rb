class AddUsernameIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :username, :name=>'username_index'
  end
end
