class Organizations::TeamsController < ApplicationController
  include OrganizationLoading

  before_action :load_organization
  before_action :is_admin, only: [:index, :show, :create]
  before_action :require_admin, expect: [:index, :show]
  before_action :set_team, except: [:index, :new, :create]

  protect_from_forgery :except => [:add_member]

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
    @members = @team.members.includes(:user)
    @members.sort_by! { |m| m.user.full_name }
    @invites = @team.invites.pending.includes(:sender)
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
    unless @team.can_be_deleted?
      return redirect_to organization_teams_path(@organization), alert: 'You cannot delete this team.'
    end

    @team.destroy
    respond_to do |format|
      format.html { redirect_to organization_teams_path(@organization), notice: "Team #{@team.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def add_member
    data = {}

    if params[:email]
      # Search by user email
      user = User.where(email: params[:email]).first
    elsif params[:user]
      # Search by user id
      user = User.find params[:user]
    end

    if user
      # Adds the user straight to the team
      if @team.members.where(user: user).count == 0
        if @team.members.create(role: 'member', user: user)
          data[:notice] = "#{user.full_name} has been added to the #{@team.name} team."
        end
      else
        data[:alert] = "#{user.full_name} is already part of the #{@team.name} team."
      end
    elsif params[:email]
      # Create the invite
      invite = @team.invites.build({
        email: params[:email],
        sender: @current_user
      })

      if invite.save
        # Send an email invitation
        if OrganizationMailer.invite_to_team(invite, @team, @current_user, params[:email]).deliver
          data[:notice] = "An invite to join #{@team.name} team has been sent to #{params[:email]}"
        else
          invite.destroy
          data[:alert] = "Could not send the email. Please try later."
        end

      else
        data[:alert] = "#{invite.errors.full_messages.join('. ')}."
      end
    end

    redirect_to organization_team_path(@organization, @team), data
  end

  def remove_member
    member = TeamMember.includes(:user).where(id: params[:member], team: @team).first
    if member and member.destroy
      if member.user == @current_user
        redirect_to organization_team_path(@organization, @team), notice: "You just left the team #{@team.name}."
      else
        redirect_to organization_team_path(@organization, @team), notice: "#{member.user.full_name} was successfully removed from the team #{@team.name}."
      end
    else
      redirect_to organization_team_path(@organization, @team), alert: 'The member specified does not exist.'
    end
  end

  def remove_invite
    @team.invites.find(params[:key]).destroy
    redirect_to organization_team_path(@organization, @team), notice: "The invite has been deleted."
  end

  private
    def set_team
      @team = Team.where(organization: @organization, id: params[:id]).first

      redirect_to organization_teams_path(@organization), alert: 'The team does not exist.' unless @team
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :role)
    end
end
