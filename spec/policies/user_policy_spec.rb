require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { UserPolicy.new(user) }
  let(:user) { Fabricate.build(:user) }

  describe '#can_subscribe?' do
    context 'not subscribed user' do
      before { user.subscription_id = nil }

      context 'expired subscription' do
        it 'return true' do
          allow(user).to receive(:valid_subscription?).and_return false
          expect(subject.can_subscribe?).to be_truthy
        end
      end

      context 'valid subscription' do
        it 'return true' do
          allow(user).to receive(:valid_subscription?).and_return true
          expect(subject.can_subscribe?).to be_truthy
        end
      end
    end

    context 'subscribed user' do
      before { user.subscription_id = 'subscription_id' }

      context 'expired subscription' do
        it 'return true' do
          allow(user).to receive(:valid_subscription?).and_return false
          expect(subject.can_subscribe?).to be_truthy
        end
      end

      context 'valid_subscription' do
        it 'return false' do
          allow(user).to receive(:valid_subscription?).and_return true
          expect(subject.can_subscribe?).to be_falsy
        end
      end
    end
  end

  describe '#can_unsubscribe?' do
    context 'not subscribed user' do
      before { user.subscription_id = nil }

      context 'expired subscription' do
        it 'return false' do
          allow(user).to receive(:valid_subscription?).and_return false
          expect(subject.can_unsubscribe?).to be_falsy
        end
      end

      context 'valid subscription' do
        it 'return false' do
          allow(user).to receive(:valid_subscription?).and_return true
          expect(subject.can_unsubscribe?).to be_falsy
        end
      end
    end

    context 'subscribed user' do
      before { user.subscription_id = 'subscription_id' }

      context 'expired subscription' do
        it 'return false' do
          allow(user).to receive(:valid_subscription?).and_return false
          expect(subject.can_unsubscribe?).to be_falsy
        end
      end

      context 'valid_subscription' do
        it 'return true' do
          allow(user).to receive(:valid_subscription?).and_return true
          expect(subject.can_unsubscribe?).to be_truthy
        end
      end
    end
  end
end
