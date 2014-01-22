module CacheHelper
  def key_for_user_session(id)
    "user-session-#{id}-" + Time.now.strftime("%I")
  end
end
