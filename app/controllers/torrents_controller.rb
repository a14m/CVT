# Torrents Controller
class TorrentsController < ApplicationController
  # POST /torrents
  def create
    TorrentCreation.call(file: request.env['rack.input'])
    render status: 201, json: { message: I18n.t('torrents.file_added') }
  rescue TorrentCreationError => e
    render status: 403, json: { message: I18n.t(e.message) }
  end
end
