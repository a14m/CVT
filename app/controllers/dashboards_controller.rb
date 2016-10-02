# Dashboard controller
class DashboardsController < ApplicationController
  def index
    @user = current_user.decorate
    @torrents = TorrentsDecorator.decorate(current_user.torrents)
  end
end
