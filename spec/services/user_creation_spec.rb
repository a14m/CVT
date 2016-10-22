require 'rails_helper'

RSpec.describe UserCreation, type: :service do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  describe '#call' do
    before { StripeMock.start }
    after  { StripeMock.stop  }

    it 'creates user with stripe_id and expires_at' do
      expect(User.count).to eq 0
      user = subject.call(email: email, password: password)
      expect(User.count).to eq 1
      expect(user.stripe_id).to match(/test_cus_/)
      expect(user.expires_at).to be_within(5.seconds).of(3.days.from_now)
    end

    it 'raises StripeError when plan is not created' do
      expect(User.count).to eq 0
      StripeMock.prepare_error(Stripe::StripeError.new, :new_customer)
      expect { subject.call(email: email, password: password) }.to raise_error \
        Stripe::StripeError
      expect(User.count).to eq 0
    end

    it 'raises ActiveRecord::RecordInvalid' do
      expect { subject.call(email: 'em@il', password: '') }.to raise_error \
        ActiveRecord::RecordInvalid
      expect(User.count).to eq 0
    end
  end
end
