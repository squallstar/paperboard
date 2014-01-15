class ApplicationController < ActionController::Base
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
    @current_user ||= User.select(:id, :first_name, :last_name).find_by(id: session[:user_id])
  end

  def current_project
    @current_project ||= @current_user.projects.find(params[:id].to_i)
    if not @current_project
      redirect_to projects_path, alert: 'That project does not exist or you don\'t have the rights to view it'
    end
  end
end
