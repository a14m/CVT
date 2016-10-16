class AddStripIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_id, :string, default: nil
    add_column :users, :expires_at, :datetime
    add_column :users, :quota, :bigint, default: 5_368_709_120
    add_index :users, :stripe_id
  end
end
