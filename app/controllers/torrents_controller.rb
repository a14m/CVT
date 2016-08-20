# Torrents Controller
class TorrentsController < ApplicationController
  # POST /torrents
  def create
    # TorrentCreation.call(torrent_params)
    flash[:success] = I18n.t('torrents.file_added')
    redirect_to dashboard_path
  end

  private

  def torrent_params
    params.require(:torrent).permit(:torrent_file)
  end
end
