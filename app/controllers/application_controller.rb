class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

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

  def current_project
    project_id = (params[:project_id] ? params[:project_id] : params[:id]).to_i
    if project_id == 0
      return redirect_to projects_path, alert: 'Project id not set'
    end
    @current_project ||= @current_user.projects.find(project_id)

  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'That project does not exist or you don\'t have the rights to see it.'
  end
end
