class Settings::BillingController < ApplicationController
  before_action :set_plans

  def index
  end

  def subscribe
  end

  private
    def set_plans
      @plans = Plan.all
    end
end
