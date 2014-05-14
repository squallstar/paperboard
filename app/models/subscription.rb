# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  plan_id            :integer
#  user_id            :integer
#  paymill_card_token :string(255)
#  paymill_card_last  :string(255)
#  paymill_id         :string(255)
#  active             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  organization_id    :integer
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  belongs_to :organization

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
      logger.info "Subscription: a new subscription have been setup with paymill_id #{paymill_id}"
    end
  rescue => e
    logger.error "Error while creating subscription for user #{user.client.id}: #{e}"
    errors.add :base, 'There was a problem with your credit card. Please try again.'
    false
  end

  def expire_at
    next_at = updated_at
    now = Time.now

    while next_at < now
      next_at += 1.months
    end

    next_at
  end

  private
  def delete_paymill_subscription
    Paperboard::Payments.unsubscribe paymill_id
    logger.info "Subscription: user #{user.id} has been unsubscribed from paymill_id #{paymill_id}"
  end
end
