require 'rails_helper'

RSpec.describe SubscriptionCreation, type: :service do
  let(:user) { Fabricate.create(:user, stripe_id: 'test_customer') }
  let(:customer) { double('customer') }
  let(:subscription) { double('subscription') }

  describe '#call' do
    it 'create user subscription' do
      expect(subject).to receive(:update_customer)\
        .with(user.stripe_id, 'card_token').and_return customer
      expect(subject).to receive(:create_subscription)\
        .with(user, customer).and_return subscription
      expect(user).to receive(:save!)

      subject.call(user: user, token: 'card_token')
    end
  end

  describe '#update_customer' do
    it 'update stripe customer#source' do
      expect(Stripe::Customer).to receive(:retrieve)\
        .with(user.stripe_id).and_return customer
      expect(customer).to receive(:source=)\
        .with('card_token').and_return customer
      expect(customer).to receive(:save)

      subject.send(:update_customer, user.stripe_id, 'card_token')
    end
  end

  describe '#create_subscription' do
    it 'create a subscription' do
      expect(customer).to receive(:id).and_return user.stripe_id
      expect(Stripe::Subscription).to receive(:create)\
        .with(customer: user.stripe_id, plan: 'basic_1').and_return subscription

      expect(subscription).to receive(:id).and_return 'subscription_id'
      expect(subscription).to receive(:current_period_end)\
        .and_return 30.days.from_now.to_i

      expect(user.subscription_id).not_to eq 'subscription_id'
      expect(user.expires_at).not_to be_within(5.seconds).of(30.days.from_now)

      subject.send(:create_subscription, user, customer)

      expect(user.subscription_id).to eq 'subscription_id'
      expect(user.expires_at).to be_within(5.seconds).of(30.days.from_now)
    end
  end
end
