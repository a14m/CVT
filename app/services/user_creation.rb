# Service Object for User/Stripe customer object creation
class UserCreation
  def call(email:, password:)
    user = User.create!(
      email: email,
      password: password,
      expires_at: 3.days.from_now
    )

    stripe_customer = Stripe::Customer.create(
      email: user.email
    )

    # Update the user with Stripe Information
    user.stripe_id = stripe_customer.id
    user.save!
    user
  rescue Stripe::StripeError => e
    Rails.logger.warn e.message
    user.destroy!
    raise e
  end
end
