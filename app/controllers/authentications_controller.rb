# Authentications Sign In/Up/Out
class AuthenticationsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  # POST /sign_up
  def sign_up
    @user = User.create(
      email: sign_up_params[:email],
      password: sign_up_params[:password]
    )

    if @user.save
      redirect_back_or_to(:dashboard, success: 'Welcome')
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render 'new_sign_up'
    end
  end

  # POST /sign_in
  def sign_in
    @user = login(
      sign_in_params[:email],
      sign_in_params[:password],
      sign_in_params[:remember_me].to_i
    )

    if @user
      redirect_back_or_to(:dashboard, success: 'Welcome Back')
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
          .permit(:email, :password, :terms_and_conditions)
  end

  def sign_in_params
    params.require(:authentication).permit(:email, :password, :remember_me)
  end
end
