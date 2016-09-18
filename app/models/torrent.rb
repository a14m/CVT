# == Schema Information
#
# Table name: torrents
#
#  id                   :uuid             not null, primary key
#  name                 :string
#  transmission_id      :integer
#  size                 :integer
#  checksum             :string
#  user_id              :integer          indexed
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  torrent_file_name    :string
#  torrent_content_type :string
#  torrent_file_size    :integer
#  torrent_updated_at   :datetime
#
# Indexes
#
#  index_torrents_on_user_id  (user_id)
#

class Torrent < ApplicationRecord
  # Relations
  belongs_to :user, required: true

  has_attached_file :torrent

  # Validations
  validates :name, presence: true
  validates :transmission_id, presence: true
  validates :size, presence: true
  validates :checksum, presence: true
  validates_attachment :torrent,
    presence: true,
    content_type: { content_type: 'application/x-bittorrent' }
end
