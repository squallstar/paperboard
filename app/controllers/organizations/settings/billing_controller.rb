class Organizations::Settings::BillingController < ApplicationController
  include OrganizationLoading

  before_action :set_plans, only: [:index]
  before_action :load_organization, only: [:index]
  before_action :require_admin

  def index
  end

  private
    def set_plans
      @plans = Plan.all
    end
end