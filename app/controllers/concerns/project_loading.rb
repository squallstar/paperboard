module ProjectLoading
  extend ActiveSupport::Concern

  def load_project
    project_id = (params[:project_id] ? params[:project_id] : params[:id]).to_i
    if project_id == 0
      return redirect_to projects_path, alert: 'Project id not set'
    end
    @current_project ||= @current_user.projects.find(project_id)

  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'That project does not exist or you don\'t have the rights to see it.'
  end
end
