# Landing Page controller
class LandingController < ApplicationController
  skip_before_action :require_login, only: [:index]
  attr_reader :current_user
end
