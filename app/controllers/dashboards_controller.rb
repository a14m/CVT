# Dashboard controller
class DashboardsController < ApplicationController
  skip_before_action :require_login, only: [:index]
end
