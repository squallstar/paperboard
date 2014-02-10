module Subscriptions
  extend ActiveSupport::Concern

  included do
    has_one :subscription, dependent: :destroy
  end

  # Calling .plan gives the plan name, while passing "projects"
  # "teams" or "users" will return the permitted number.
  def plan(key = nil)
    @plan ||= subscription ? subscription.plan.name : "free"
    return @plan unless key
    AppSettings.plans[@plan]["n_#{key}"]
  end
end