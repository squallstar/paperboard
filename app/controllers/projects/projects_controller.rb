class Projects::ProjectsController < ApplicationController
  include ProjectLoading

  before_action :load_project, only: [:show]

  # GET /projects
  def index
    @projects = @current_user.projects
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = @current_project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        # Sets the owner to the current user
        @project.members.create role: 'owner', user: @current_user

        Analytics.track(
          user_id: @current_user.id,
          event: 'Created a project'
        )

        format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    membership = ProjectMember.where(user: current_user, project_id: params[:id]).first
    if membership.role == 'owner'
      membership.project.destroy

      redirect_to projects_path, alert: 'Project was successfully deleted.'
    else
      redirect_to projects_path, alert: 'You are not the owner of this project.'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end