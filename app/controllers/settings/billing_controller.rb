class Settings::BillingController < ApplicationController
  before_action :set_plans, only: [:index]
  before_action :set_current_subscription

  def index
  end

  def subscribe
    @plan = Plan.find(params[:plan_id])
    @subscription = @plan.subscriptions.build

    if params[:subscription]
      @subscription = @plan.subscriptions.build(subscription_params)
      @subscription.user = User.find(@current_user.id)

      if @subscription.save_with_payment
        redirect_to settings_billing_path, alert: "Thank you for subscribing!"
      end
    end
  end

  def delete_subscription
    if @current_user.has_active_subscription
      @current_user.subscription.destroy
      redirect_to settings_billing_path, alert: 'Your subscription have been deleted'
    end
  end

  private
    def set_plans
      @plans = Plan.all
    end

    def set_current_subscription
      @subscription ||= @current_user.subscription
    end

    def subscription_params
      params.require(:subscription).permit(:paymill_card_token, :paymill_card_last)
    end
end