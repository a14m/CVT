# Manage stripe subscriptions via webhooks
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login

  def manage
    event = JSON.parse(request.body.read)
    case event['type']
    when 'invoice.payment_succeeded'
      renew_subscription event['data']['object']
    when 'customer.subscription.deleted'
      unsubscribe_user event['data']['object']
    else
      fail ApplicationError, "unhandled event #{event['type']}"
    end
    render status: 200, json: { status: :ok }
  rescue ApplicationError => e
    logger.warn e.message
    render status: 422, json: { error: 'webhook failed' }
  end

  private

  def renew_subscription(event)
    user = User.find_by(stripe_id: event['customer'])
    fail ApplicationError, "cannot find user #{event['customer']}" unless user
    user.expires_at = Time.at(event['lines']['data'][0]['period']['end'])
    user.save!
  end

  def unsubscribe_user(event)
    user = User.find_by(stripe_id: event['customer'])
    return unless user
    user.subscription_id = nil
    user.expires_at = Time.current
    user.save!
  end
end
