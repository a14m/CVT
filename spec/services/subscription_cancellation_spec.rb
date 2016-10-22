require 'rails_helper'

RSpec.describe SubscriptionCancellation, type: :service do
  let(:subscription) { double('subscription') }
  let(:user) { Fabricate.build(:user, subscription_id: 'test_subscription') }

  describe '#call' do
    it 'cancels subscription' do
      expect(Stripe::Subscription).to receive(:retrieve)\
        .with(user.subscription_id).and_return subscription
      expect(subscription).to receive(:canceled_at).and_return false
      expect(subscription).to receive(:delete).with(at_period_end: true)
      subject.call(user: user)
    end

    it 'raises SubscriptionError' do
      expect(Stripe::Subscription).to receive(:retrieve)\
        .with(user.subscription_id).and_return subscription
      expect(subscription).to receive(:canceled_at).and_return true
      expect { subject.call(user: user) }.to raise_error SubscriptionError
    end
  end
end
