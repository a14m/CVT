# Base Application Controller Class
class ApplicationController < ActionController::Base
  before_action :require_login

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # before action used to insure guest only routes
  def require_guest
    redirect_back_or_to(:dashboard) if current_user
  end

  private

  def not_authenticated
    redirect_to sign_in_path, notice: I18n.t('authentications.login_required')
  end
end
