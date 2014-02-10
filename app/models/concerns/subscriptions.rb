module Subscriptions
  extend ActiveSupport::Concern

  included do
    has_one :subscription, dependent: :destroy
  end

  def plan
    @plan ||= subscription ? subscription.plan.name : "free"
  end
end