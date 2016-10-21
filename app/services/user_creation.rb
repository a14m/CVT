# Service Object for User/Stripe customer object creation
class UserCreation
  def call(email:, password:)
    stripe_customer = Stripe::Customer.create(
      email: email
    )

    User.create!(
      email: email,
      password: password,
      expires_at: 3.days.from_now,
      stripe_id: stripe_customer.id
    )
  end
end
