# User controller
class UsersController < ApplicationController
  # GET /user
  def show
    @user = current_user.decorate
  end

  # PUT /user/password
  def password
    authenticated = current_user.valid_password?(password_params[:password])
    if authenticated
      current_user.change_password!(password_params[:new_password])
      flash[:success] = I18n.t('authentications.password_updated')
    else
      flash[:error] = I18n.t('authentications.invalid_password')
    end
    redirect_to user_path
  end

  # POST /user/subscribe
  def subscribe
    fail SubscriptionError unless UserPolicy.new(current_user).can_subscribe?
    SubscriptionCreation.new.call(
      user: current_user,
      token: params[:stripeToken]
    )
    flash[:success] = I18n.t('subscription.subscribed',
      expires_at: current_user.decorate.expires_at)
  rescue SubscriptionError
    flash[:notice] = I18n.t('subscription.already_subscribed',
      expires_at: current_user.decorate.expires_at)
  rescue Stripe::StripeError => e
    flash[:error] = e.message
  ensure
    redirect_to :user
  end

  # DELETE /user/unsubscribe
  def unsubscribe
    fail SubscriptionError unless UserPolicy.new(current_user).can_unsubscribe?
    SubscriptionCancellation.new.call(user: current_user)
    flash[:success] = I18n.t('subscription.unsubscribed')
  rescue SubscriptionError
    flash[:notice] = I18n.t('subscription.already_unsubscribed',
      expires_at: current_user.decorate.expires_at)
  rescue Stripe::StripeError => e
    flash[:error] = e.message
  ensure
    redirect_to :user
  end

  private

  def password_params
    params.require(:user).permit(:password, :new_password)
  end
end
