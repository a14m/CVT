class AddCanceledAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :canceled_at, :datetime, default: nil
  end
end
