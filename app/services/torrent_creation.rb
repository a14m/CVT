# Service Object for torrent object creation
class TorrentCreation
  def call(user:, file:)
    transmission_torrent = transmission_add!(file)
    policy = TorrentPolicy.new(user, transmission_torrent)
    policy.add?
    torrent = create_torrent!(user, transmission_torrent, file)
    transmission_torrent.start! if policy.start?
    torrent
  end

  private

  def transmission_add!(file)
    torrent = Transmission::RPC::Torrent.add(
      metainfo: Base64.strict_encode64(file.read),
      paused: true
    )
    fail InvalidFileError, 'torrents.invalid_file' unless torrent
    torrent
  rescue NoMethodError => e
    raise ApplicationError, e
  end

  def create_torrent!(user, torrent, file)
    user.torrents.create!(
      name: torrent.name,
      transmission_id: torrent.id,
      size: torrent.size,
      checksum: torrent.hash,
      torrent: file.tempfile
    )
  end
end
