# Torrents Controller
class TorrentsController < ApplicationController
  # POST /torrents
  def create
    TorrentCreation.call(file: torrent_params[:file])
    render status: 201, json: { message: I18n.t('torrents.file_added') }
  rescue TorrentCreationError => e
    render status: 403, json: { message: I18n.t(e.message) }
  end

  def torrent_params
    params.require(:torrent).permit(:file)
  end
end
