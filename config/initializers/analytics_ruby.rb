Analytics = AnalyticsRuby
Analytics.init({
  secret: ENV['ANALYTICS_ID'],
  on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})