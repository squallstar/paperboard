module Paperboard
  class Payments
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
      payment = Paymill::Payment.create token: card_token, client: client
      Rails.logger.info "Payment created with token #{card_token} for client #{client}"
      payment
    end

    def self.subscribe(plan, client, card_token)
      payment = create_payment card_token, client
      Paymill::Subscription.create offer: plan, client: client, payment: payment.id
    end

    def self.unsubscribe(subscription_id)
      Paymill::Subscription.delete subscription_id
    end

    def self.destroy_all
      return unless Rails.env == 'development'

      for client in Paymill::Client.all
        p "Reading client #{client.id}"

        begin

          if client.payment
            p 'The client has payments'
            for payment in client.payment
              p "Deleting payment #{payment['id']}"
              Paymill::Payment.delete payment['id']
            end
          end

          if client.subscription
            p 'The client has subscriptions'
            for sub in client.subscription
              p "Deleting subscription #{sub['id']}"
              Paymill::Subscription.delete sub['id']
            end
          end

        rescue
          # p "Error: #{$!}"
        ensure
          p "Deleting the client #{client.id}"
          Paymill::Client.delete client.id
        end
        p '------------'
        nil
      end

      p 'Clearing all client_ids'
      User.update_all(client_id: nil)

      p 'Done!'
    end
  end
end
