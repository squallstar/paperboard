class InvitesController < ApplicationController
  before_action :current_project
  before_action :set_invite, only: [:destroy]

  def index
    @invites = @current_project.invites.includes(:user)
  end

  def new
    @invite = @project.invites.build
  end

  def create
    invite = @project.invites.create(invite_params)
    invite.project = @project
    invite.user = @current_user

    respond_to do |format|
      if invite.save
        format.html { redirect_to @project.invites, notice: "Project invite was successfully sent to #{invite.email}." }
        format.json { render action: 'show', status: :created, location: @project.invites }
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
