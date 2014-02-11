class Organizations::TeamsController < ApplicationController
  include OrganizationLoading

  before_action :load_organization
  before_action :is_admin, only: [:index, :show]
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy, :remove_member]
  before_action :set_team, only: [:edit, :update, :destroy, :remove_member]

  # GET /teams
  # GET /teams.json
  def index
    @teams = @organization.teams
  end

  # GET /teams/new
  def new
    @team = Team.new role: 'standard'
  end

  # GET /teams/1/edit
  def edit
  end

  def show
    @team = Team.where(organization_id: params[:organization_id], id: params[:id]).includes({members: :user}).first
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.organization = @organization

    respond_to do |format|
      if @team.save
        # Sets the admin to the current user
        @team.members.create role: 'admin', user: @current_user

        format.html { redirect_to organization_team_path(@organization, @team), notice: "Team #{@team.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team #{@team.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if not @team.can_be_deleted?
      return redirect_to organization_teams_path(@organization), alert: 'You cannot delete this team.'
    end

    @team.destroy
    respond_to do |format|
      format.html { redirect_to organization_teams_path(@organization), notice: "Team #{@team.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def remove_member
    member = TeamMember.includes(:user).where(id: params[:member], team: @team, organization: @organization)
    if member.destroy
      if member.user == @current_user
        redirect_to organization_teams_path(@organization), notice: "You just left the team #{@team.name}."
      else
        redirect_to organization_teams_path(@organization), notice: "#{user.full_name} was successfully removed from the team #{@team.name}."
      end
    end
  end

  private
    def set_team
      @team = Team.where(organization: @organization, id: params[:id]).first

      if not @team
        redirect_to organization_teams_path(@organization), alert: 'The team does not exist.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :role)
    end
end
