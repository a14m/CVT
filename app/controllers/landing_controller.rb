# Landing Page controller
class LandingController < ApplicationController
  skip_before_action :require_login, only: [:index]
end
