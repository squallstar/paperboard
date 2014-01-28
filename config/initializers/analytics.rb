Analytics = AnalyticsRuby
Analytics.init({
    secret: ENV['ANALYTICS_ID'],          # The write key for squallstar/paperboard
    on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})