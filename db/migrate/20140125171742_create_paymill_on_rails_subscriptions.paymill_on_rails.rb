# This migration comes from paymill_on_rails (originally 20131111132308)
class CreatePaymillOnRailsSubscriptions < ActiveRecord::Migration
  def change
    create_table :paymill_on_rails_subscriptions do |t|

      t.string  :name
      t.string  :email
      t.integer :plan_id
      t.string  :paymill_id

      t.timestamps
    end
  end
end
