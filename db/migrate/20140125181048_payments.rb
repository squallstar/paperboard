class Payments < ActiveRecord::Migration
  def change
    create_table "plans" do |t|
      t.string :paymill_id
      t.string :name
      t.float :price

      t.timestamps
    end

    create_table "subscriptions" do |t|
      t.references :plan, index: true
      t.references :user, index: true

      t.string :paymill_card_token
      t.string :paymill_card_last
      t.string :paymill_id
      t.boolean :active

      t.timestamps
    end
  end
end
