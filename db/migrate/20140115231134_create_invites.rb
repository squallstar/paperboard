class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.boolean :accepted, index: true
      t.string :email, index: true
      t.string :key
      t.references :project, index: true

      t.references :user
      t.references :sender

      t.timestamps
    end
  end
end
