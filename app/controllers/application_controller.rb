# Base Application Controller Class
class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
