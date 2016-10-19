# Torrent policy
class TorrentPolicy
  attr_reader :user, :torrent

  def initialize(user, torrent)
    @user = user
    @torrent = torrent
  end

  def add?
    fail TorrentCreationError, 'subscription.expired' unless valid_subscription?
    fail TorrentCreationError, 'subscription.enough_space' unless enough_space?
    true
  end

  def start?
    torrent.bytes_left.positive?
  end

  private

  def enough_space?
    total_size = user.usage + torrent.size
    total_size < user.quota
  end

  def valid_subscription?
    user.expires_at? && user.expires_at > Date.today
  end
end
