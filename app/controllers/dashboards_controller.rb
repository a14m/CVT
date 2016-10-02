# Dashboard controller
class DashboardsController < ApplicationController
  def index
    @user = current_user.decorate
  end
end
