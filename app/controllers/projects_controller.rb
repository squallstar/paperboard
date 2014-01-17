class ProjectsController < ApplicationController
  before_action :current_project, only: [:show]

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
    render "project/index"
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        # Sets the owner to the current user
        @project.members.create role: 'owner', user: @current_user

        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    membership = Project.find(params[:id]).members.where(user: current_user).first
    if membership.role == 'owner'
      membership.project.destroy

      redirect_to projects_path, notice: 'Project was successfully deleted.'
    else
      format.html { redirect_to projects_path, notice: 'You are not the owner of this project.' }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end