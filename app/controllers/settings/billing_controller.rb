class Settings::BillingController < ApplicationController
  before_action :set_plans, only: [:index]
  before_action :set_subscription, only: [:subscribe]

  def index
  end

  def subscribe
    if params[:subscription]
      @subscription = @plan.subscriptions.build(subscription_params)
      @subscription.user = User.find(@current_user.id)

      if @subscription.save_with_payment
        redirect_to settings_billing_path, :notice => "Thank you for subscribing!"
      end
    end
  end

  private
    def set_plans
      @plans = Plan.all
    end

    def set_subscription
      @plan = Plan.find(params[:plan_id])
      @subscription = @plan.subscriptions.build
    end

    def subscription_params
      params.require(:subscription).permit(:paymill_card_token, :paymill_card_last)
    end
end