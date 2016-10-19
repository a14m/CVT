# Service Object for User/Stripe customer object creation
class UserCreation
  def call(email:, password:)
    user = User.create!(email: email, password: password)
    stripe_customer = Stripe::Customer.create(
      email: user.email,
      plan: 'basic_1'
    )
    # Update the user with Stripe Information
    user.stripe_id = stripe_customer.id
    user.expires_at = Time.at(stripe_customer.subscriptions.first.trial_end)
    user.save!
    user
  rescue Stripe::StripeError => e
    User.find_by(email: email).destroy!
    Rails.logger.warn e.message
    raise e
  end
end
