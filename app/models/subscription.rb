class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  before_destroy :delete_paymill_subscription

  validates_presence_of :plan
  validates_presence_of :user

  def save_with_payment
    if valid?
      subscription = Paperboard::Payments.subscribe plan.paymill_id, user.client.id, paymill_card_token

      self.paymill_id = subscription.id
      self.active = true

      # If needed, delete the old subscription before saving
      Subscription.where(user: user).destroy_all

      save!
      logger.info "Subscription: a new subscription have been setup with paymill_id #{self.paymill_id}"
    end
  rescue => e
    logger.error "Error while creating subscription for user #{user.client.id}: #{e}"
    errors.add :base, "There was a problem with your credit card. Please try again."
    false
  end

  def expire_at
    # TODO: needs to be improved to change every month
    updated_at + 1.months
  end

  private
    def delete_paymill_subscription
      Paperboard::Payments.unsubscribe self.paymill_id
      logger.info "Subscription: user #{user.id} has been unsubscribed from paymill_id #{self.paymill_id}"
    end
end