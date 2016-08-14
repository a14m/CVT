class AddAttachmentTorrentToTorrents < ActiveRecord::Migration
  def self.up
    change_table :torrents do |t|
      t.attachment :torrent
    end
  end

  def self.down
    remove_attachment :torrents, :torrent
  end
end
