class CreateTeamInvites < ActiveRecord::Migration
  def change
    create_table :team_invites do |t|
      t.boolean :accepted, index: true
      t.string :email, index: true
      t.string :key, index: true

      t.references :sender, index: true
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
