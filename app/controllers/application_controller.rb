class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize


  protected

  def authorize
    unless current_user
      session.destroy
      redirect_to login_url, notice: "Please log in"
    end
  end

  private

  def current_user
    @current_user ||= User.select(:id).find_by(id: session[:user_id])
  end
end
