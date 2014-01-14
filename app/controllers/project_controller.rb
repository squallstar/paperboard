class ProjectController < ApplicationController
  before_action :set_project

  def index
  end

  private

  def set_project
    @project = @current_user.project_with_id(params[:id])
    if not @project
      redirect_to projects_path, alert: 'That project does not exist or you don\'t have the rights to view it'
    end
  end
end
