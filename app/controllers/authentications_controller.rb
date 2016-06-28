# Authentications Sign In/Up/Out
class AuthenticationsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :require_guest, only: [:new_sign_in, :new_sign_up]

  # POST /sign_up
  def sign_up
    @user = User.create!(
      email: sign_up_params[:email],
      password: sign_up_params[:password]
    )
    auto_login(@user)
    flash[:success] = I18n.t('authentications.sign_up_success')
    redirect_to :dashboard
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.record.errors.full_messages.to_sentence
    render 'new_sign_up'
  end

  # POST /sign_in
  def sign_in
    @user = login(
      sign_in_params[:email],
      sign_in_params[:password],
      sign_in_params[:remember_me].to_i > 0
    )

    if @user
      redirect_back_or_to(:dashboard)
    else
      flash.now[:error] = I18n.t('authentications.invalid_credentials')
      render 'new_sign_in'
    end
  end

  # DELETE /sign_out
  def destroy
    logout
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:authentication)
          .permit(:email, :password, :confirm_password, :terms_and_conditions)
  end

  def sign_in_params
    params.require(:authentication).permit(:email, :password, :remember_me)
  end
end
