class PaymentGate

  def self.find_client(id)
    Paymill::Client.find id
  end

  def self.create_client(attributes)
    Paymill::Client.create attributes
  end

  def self.update_client(client, attributes)
    client.update_attributes attributes
  end

  def self.delete_client(id)
    Paymill::Client.delete id
  end

  def self.create_payment(card_token, client)
    Paymill::Payment.create token: card_token, client: client
  end

  def self.subscribe(plan, client, card_token)
    payment = self.create_payment card_token, client
    Paymill::Subscription.create offer: plan, client: client, payment: payment
  end

  def self.unsubscribe(subscription_id)
    Paymill::Subscription.delete subscription_id
  end

end