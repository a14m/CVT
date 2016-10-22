# Service Object for Subscription cancellation
class SubscriptionCancellation
  def call(user:)
    subscription = Stripe::Subscription.retrieve(user.subscription_id)
    fail SubscriptionError if subscription.canceled_at
    subscription.delete(at_period_end: true)
  end
end
