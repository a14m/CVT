# Torrent policy
class TorrentPolicy < Struct.new(:user, :torrent)

  def add?
    fail TorrentCreationError, 'subscription.expired' if expired_subscription?
    fail TorrentCreationError, 'subscription.enough_space' unless enough_space?
    true
  end

  def start?
    torrent.bytes_left.positive?
  end

  private

  def enough_space?
    total_size = user.torrents.sum(:size) + torrent.size
    total_size < user.quota
  end

  def expired_subscription?
    user.expires_at < Date.today
  end
end
