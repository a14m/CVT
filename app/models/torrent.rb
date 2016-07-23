# == Schema Information
#
# Table name: torrents
#
#  id              :uuid             not null, primary key
#  name            :string
#  transmission_id :integer
#  size            :integer
#  checksum        :string
#  path            :string
#  file            :string
#  user_id         :integer          indexed
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_torrents_on_user_id  (user_id)
#

class Torrent < ApplicationRecord
  # Relations
  belongs_to :user, required: true

  # Validations
  validates :name, presence: true
  validates :transmission_id, presence: true
  validates :size, presence: true
  validates :checksum, presence: true
  validates :path, presence: true
  validates :file, presence: true
end
