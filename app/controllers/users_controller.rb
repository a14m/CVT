# User controller
class UsersController < ApplicationController
  # GET /user
  def show
    @user = current_user.decorate
  end

  # DELETE /user/unsubscribe
  def unsubscribe
    if current_user.subscription_id?
      current_user.subscription_id = nil
      current_user.save!
      flash[:success] = I18n.t('subscription.unsubscribed')
    else
      flash[:notice] = I18n.t('subscription.already_unsubscribed',
        expires_at: current_user.decorate.expires_at)
    end
    redirect_to :user
  end
end
