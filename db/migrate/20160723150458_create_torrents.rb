class CreateTorrents < ActiveRecord::Migration[5.0]
  def change
    create_table :torrents, id: :uuid do |t|
      t.string :name
      t.integer :transmission_id
      t.integer :size
      t.string :checksum
      t.string :path
      t.string :file
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
