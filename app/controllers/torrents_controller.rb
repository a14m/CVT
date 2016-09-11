# Torrents Controller
class TorrentsController < ApplicationController
  # POST /torrents
  def create
    TorrentCreation.call(torrent_params)
    render status: 201, json: { message: I18n.t('torrents.file_added') }
  rescue TorrentCreationError => e
    render status: 403, json: { message: I18n.t(e.message) }
  end

  private

  def torrent_params
    params.permit(:torrent_file)
  end
end
