# Base Application Controller Class
class ApplicationController < ActionController::Base
  before_action :require_login

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # before action used to insure guest only routes
  def require_guest
    redirect_to(:dashboard) if current_user
  end

  private

  def current_user
    @current_user ||= super && User.includes(:torrents).find(@current_user.id)
  end

  def not_authenticated
    redirect_to sign_in_path, notice: I18n.t('authentications.login_required')
  end
end
