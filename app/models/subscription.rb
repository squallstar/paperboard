class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  validates_presence_of :plan_id
  validates_presence_of :user

  attr_accessor :paymill_card_token
  attr_accessor :paymill_card_last

  def save_with_payment
    if valid?
      payment = Paymill::Payment.create token: paymill_card_token, client: user.client.id
      subscription = Paymill::Subscription.create offer: plan.paymill_id, client: user.client.id, payment: payment.id

      self.paymill_id = subscription.id
      save!
    end
  rescue Paymill::PaymillError => e
    logger.error "Paymill error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card. Please try again."
    false
  end

end