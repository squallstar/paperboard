class InvitesController < ApplicationController
  before_action :current_project
  before_action :set_invite, only: [:destroy]
  before_action :set_invites, only: [:index]

  skip_before_action :current_project, only: [:accept]

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
    invite = Invite.where(key: params[:key]).first
    if invite
      @current_project = Project.find(params[:project_id])
      if invite.accepted
        redirect_to project_path(@current_project)
      else
        invite.accepted = true
        invite.user = @current_user
        invite.save

        @current_project.members.create role: 'member', user: @current_user
        redirect_to project_path(@current_project), notice: "You joined the project #{@current_project.name}."
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
      @invite = Invite.find(params[:id])
    end

    def invite_params
      params.require(:invite).permit(:email)
    end
end
