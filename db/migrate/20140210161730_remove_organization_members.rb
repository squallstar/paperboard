class RemoveOrganizationMembers < ActiveRecord::Migration
  def change
    # We don't use organization members anymore
    drop_table :organization_members

    # Preparing for organization subscriptions
    add_reference :subscriptions, :organization, index: true
  end
end
