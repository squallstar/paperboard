class Projects::MembersController < ApplicationController
  before_action :current_project
  before_action :is_admin

  def index
    @members = @current_project.members.includes(:user)
  end

  def destroy
    return if not is_admin

    member = ProjectMember.where(id: params[:id]).first

    # Deletes the invitation if was there
    Invite.where(project: @current_project, user: member.user).limit(1).destroy_all

    # Finally deletes the member
    member.destroy

    respond_to do |format|
      format.html { redirect_to project_members_path(@current_project) }
      format.json { head :no_content }
    end
  end

  private
    def is_admin
      @is_admin ||= ProjectMember.select(:role).where(project: @current_project, user: @current_user, role: 'owner').count > 0
    end
end