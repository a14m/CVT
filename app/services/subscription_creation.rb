# Service Object for Subscription creation
class SubscriptionCreation
  def call(user:, token:)
    customer = update_customer(user.stripe_id, token)
    create_subscription(user, customer)
    user.save!
  end

  private

  def update_customer(id, card)
    customer = Stripe::Customer.retrieve(id)
    customer.source = card
    customer.save
  end

  def create_subscription(user, customer)
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      plan: 'basic_1'
    )
    user.subscription_id = subscription.id
    user.expires_at = Time.at(subscription.current_period_end)
    subscription
  end
end
