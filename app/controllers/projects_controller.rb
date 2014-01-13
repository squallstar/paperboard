class ProjectsController < ApplicationController

  # GET /projects
  def show
    @memberships = @current_user.projects.includes(project: :members)
  end

  # GET /projects/new
  def new
    @project = Project.new
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

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name)
  end

end
