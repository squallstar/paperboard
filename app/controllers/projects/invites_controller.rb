class Projects::InvitesController < ApplicationController
  include ProjectLoading

  before_action :load_project, only: [:index, :create, :destroy]
  before_action :set_invite, only: [:destroy]
  before_action :set_invites, only: [:index]

  def index
    @new_invite = @current_project.invites.build
  end

  def create
    invite = @current_project.invites.build(invite_params)
    invite.project = @current_project
    invite.sender = @current_user

    respond_to do |format|
      if invite.save
        ProjectMailer.send_invite(invite, @current_user).deliver

        format.html { redirect_to project_invites_path(@current_project), notice: "Project invite was successfully sent to #{invite.email}." }
        format.json { render json: invite, status: :created }
      else
        format.html {
          set_invites
          @new_invite = invite
          render action: 'index'
        }
        format.json { render json: invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    invite = ProjectInvite.where(key: params[:key]).first
    if invite
      @current_project = Project.find(params[:project_id])
      if invite.accepted
        # Already accepted, just redirect
        redirect_to project_path(@current_project)
      else
        # Check if the user that wants to accept belongs to the project
        if ProjectMember.where(project_id: params[:project_id], user: @current_user).count > 0
          redirect_to project_path(@current_project), notice: "You already joined this project."
        else
          # Ok, we can accept the invite
          invite.accept_with_user(@current_user)

          redirect_to project_path(@current_project), notice: "You joined the project #{@current_project.name}."
        end
      end
    else
      redirect_to projects_path
    end
  end

  def destroy
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to project_invites_path(@current_project) }
      format.json { head :no_content }
    end
  end

  private

    def set_invites
      @invites = @current_project.invites.includes(:user, :sender).order(:accepted, :email)
    end

    def set_invite
      @invite = ProjectInvite.find(params[:id])
    end

    def invite_params
      params.require(:project_invite).permit(:email)
    end
end
