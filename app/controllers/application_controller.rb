class ApplicationController < ActionController::Base
  include CacheHelper

  protect_from_forgery with: :exception
  before_filter :set_start_time
  before_action :authorize

  attr_reader :current_user

  protected

  def authorize
    unless current_user
      session.destroy
      session[:return_to] = request.fullpath

      redirect_to login_url, notice: "Please log in"
    end
  end

  private
    def set_start_time
      @start_time = Time.now.usec
    end

    def current_user
      return unless session[:user_id]

      @current_user ||= Rails.cache.fetch key_for_user_session(session[:user_id]) do
        User.select(:id, :full_name).find_by(id: session[:user_id])
      end
    end
end
