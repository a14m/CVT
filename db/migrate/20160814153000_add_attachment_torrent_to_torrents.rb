class AddAttachmentTorrentToTorrents < ActiveRecord::Migration[5.0]
  def change
    change_table :torrents do |t|
      t.attachment :torrent
    end
  end
end
