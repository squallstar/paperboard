class InvitesController < ApplicationController
  before_action :current_project
  before_action :set_invite, only: [:destroy]

  def index
    @invites = @current_project.invites.includes(:user).order(:accepted, :email)
    @new_invite = @current_project.invites.build
  end

  def create
    invite = @current_project.invites.build(invite_params)
    invite.accepted = false
    invite.project = @current_project
    invite.user = @current_user

    respond_to do |format|
      if invite.save
        ProjectMailer.send_invite(invite).deliver

        format.html { redirect_to project_invites_path(@current_project), notice: "Project invite was successfully sent to #{invite.email}." }
        format.json { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.invites.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to @project.invites }
      format.json { head :no_content }
    end
  end

  private

    def set_invite
      @invite = Invite.find(params[:id])
    end

    def invite_params
      params.require(:invite).permit(:email)
    end
end
