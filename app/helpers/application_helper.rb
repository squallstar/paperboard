module ApplicationHelper
  def analytics_identify(user)
    return unless AnalyticsRuby?
    AnalyticsRuby.identify user
  end

  def analytics_track(event)
    return unless AnalyticsRuby?
    if not event.user_id?
      event.user_id = @current_user.id
    end
    AnalyticsRuby.track event
  end
end
