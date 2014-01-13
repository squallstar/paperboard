class AddSignupToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :is_active
      t.boolean :email_verified
      t.index :email
      t.index :is_active
    end
  end
end
