module Subscriptions
  extend ActiveSupport::Concern

  included do
    has_one :subscription, dependent: :destroy
  end

  # Calling .plan gives the plan name, while passing "projects"
  # "teams" or "users" will return the permitted number.
  # Calling "projects_left" will return the number of projects the user/organization can create
  def plan(key = nil)
    @plan ||= subscription ? subscription.plan.name : 'free'
    return @plan unless key

    if key == 'projects_left'
      return AppSettings.plans[@plan]['n_projects'] - projects.size
    end

    AppSettings.plans[@plan]["n_#{key}"]
  end

  def has_active_subscription
    subscription && subscription.active
  end
end
