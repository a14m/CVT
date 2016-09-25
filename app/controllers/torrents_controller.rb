# Torrents Controller
class TorrentsController < ApplicationController
  # POST /torrents
  def create
    TorrentCreation.call(user: current_user, file: torrent_params[:file])
    render status: 201, json: { message: I18n.t('torrents.file_added') }
  rescue InvalidFileError => e
    render status: 400, json: { message: I18n.t(e.message) }
  rescue TorrentCreationError => e
    render status: 403, json: { message: I18n.t(e.message) }
  rescue ActiveRecord::RecordInvalid => e
    logger.warn e.message
    render status: 422, json: { message: I18n.t('torrents.duplicate_file') }
  rescue ApplicationError
    render status: 500, json: { message: I18n.t('torrents.service_stopped') }
  end

  def torrent_params
    params.require(:torrent).permit(:file)
  end
end
