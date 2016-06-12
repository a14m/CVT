# Base Application Controller Class
class ApplicationController < ActionController::Base
  before_action :require_login

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def not_authenticated
    redirect_to sign_in_path, notice: I18n.t('authentications.login_required')
  end
end
