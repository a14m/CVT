class AddSubscriptionIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscription_id, :string, default: nil
    add_index :users, :subscription_id
  end
end
