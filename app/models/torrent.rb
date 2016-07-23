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
#  progress        :float
#  status          :integer
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
  belongs_to :user
end
