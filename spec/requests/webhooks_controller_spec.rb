require 'rails_helper'

RSpec.describe WebhooksController, type: :request do
  describe '#manage' do
    before { StripeMock.start }
    after  { StripeMock.stop  }

    let!(:user) do
      Fabricate.create(:user, stripe_id: 'cus_id', subscription_id: 'sub_id')
    end

    context 'unhandled event' do
      it 'returns 422' do
        event = StripeMock.mock_webhook_event('customer.created')
        post '/webhooks', params: event.to_json
        expect(response.status).to eq 422
      end
    end

    context 'customer.subscription.delete' do
      it 'returns 200 and ignore non existing user' do
        event = StripeMock.mock_webhook_event('customer.subscription.deleted')
        post '/webhooks', params: event.to_json
        user.reload
        expect(response.status).to eq 200
        expect(user.subscription_id).not_to be_nil
        expect(user.expires_at).to be_within(5.seconds).of(3.days.from_now)
      end

      it 'returns 200 and update user' do
        event = StripeMock.mock_webhook_event(
          'customer.subscription.deleted', customer: 'cus_id'
        )
        post '/webhooks', params: event.to_json
        user.reload
        expect(response.status).to eq 200
        expect(user.subscription_id).to be_nil
        expect(user.expires_at).to be_within(5.seconds).of(Time.current)
      end
    end

    context 'invoice.payment_succeeded' do
      it 'returns 422' do
        event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
        post '/webhooks', params: event.to_json
        expect(response.status).to eq 422
      end

      it 'returns 200 and update user' do
        event = StripeMock.mock_webhook_event(
          'invoice.payment_succeeded', customer: 'cus_id'
        )
        post '/webhooks', params: event.to_json
        expect(response.status).to eq 200
        user.reload
        expect(user.subscription_id).to eq 'sub_id'
        expect(user.expires_at).not_to be_within(5.seconds).of(Time.current)
      end
    end
  end
end
