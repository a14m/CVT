# User policy
class UserPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def can_subscribe?
    # equivalent to !(user.subscription_id? && user.valid_subscription?)
    !user.subscription_id? || !user.valid_subscription?
  end

  def can_unsubscribe?
    # equivalent to !can_subscribe?
    user.subscription_id? && user.valid_subscription?
  end
end
