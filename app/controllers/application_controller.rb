class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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

  def current_user
    @current_user ||= User.select(:id, :first_name, :last_name).find_by(id: session[:user_id])
  end
end
