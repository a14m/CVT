# Reset/Update password controller
class PasswordsController < ApplicationController
  skip_before_action :require_login
  before_action :require_guest,
    only: [:new_reset_password_instructions, :new_reset_password]

  # POST /reset_password
  def reset_password_instructions
    @user = User.find_by(email: params[:password_reset][:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = I18n.t('passwords.reset_instructions_sent')
    redirect_to :root
  end

  # GET /:token/reset_password
  def new_reset_password
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user
  end

  # POST /:token/reset_password
  def reset_password
    @user = User.load_from_reset_password_token(params[:token])
    fail NotFoundError unless @user
    @user.change_password!(params[:password_reset][:password])
    flash[:success] = I18n.t('passwords.reset_success')
  rescue ActiveRecord::RecordInvalid, NotFoundError
    flash[:error] = I18n.t('passwords.reset_failed')
  ensure
    redirect_to :root
  end
end
