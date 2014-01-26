class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  before_destroy :delete_paymill_subscription

  validates_presence_of :plan
  validates_presence_of :user

  def save_with_payment
    if valid?
      payment = Paymill::Payment.create token: paymill_card_token, client: user.client.id
      subscription = Paymill::Subscription.create offer: plan.paymill_id, client: user.client.id, payment: payment.id

      self.paymill_id = subscription.id
      self.active = true

      # If needed, delete the old subscription before saving
      Subscription.where(user: user).destroy_all

      save!
      logger.info "Subscription: a new subscription have been setup with paymill_id #{self.paymill_id}"
    end
  rescue Paymill::PaymillError => e
    logger.error "Paymill error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card. Please try again."
    false
  end

  private
    def delete_paymill_subscription
      Paymill::Subscription.delete self.paymill_id
      logger.info "Subscription: user #{user.id} has been unsubscribed from paymill_id #{self.paymill_id}"
    end
end