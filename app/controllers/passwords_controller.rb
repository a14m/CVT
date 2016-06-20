# Reset/Update password controller
class PasswordsController < ApplicationController
  skip_before_action :require_login
  before_action :require_guest,
    only: [:new_reset_password_instructions, :new_reset_password]

  # POST /reset_password
  def reset_password_instructions
    @user = User.find_by(email: params[:reset_password][:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_back_or_to(:root,
      success: I18n.t('passwords.reset_instructions_sent'))
  end

  # POST /:token/reset_password
  def reset_password
  end
end
