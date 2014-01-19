class Organizations::MembersController < ApplicationController
  include OrganizationLoading

  before_action :load_organization, only: [:index, :create, :destroy]
  before_action :is_admin, only: [:index]
  before_action :require_admin, only: [:create, :update, :destroy]

  def index
    @members = @organization.members.includes(:user)
  end

  def create
    @organization_member = OrganizationMember.new(organization_member_params)

    respond_to do |format|
      if @organization_member.save
        format.html { redirect_to organization_path(@organization), notice: 'Organization member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization_member.update(organization_member_params)
        format.html { redirect_to @organization_member, notice: 'Organization member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    OrganizationMember.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to organization_members_url(@organization) }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_member_params
      params.require(:organization_member).permit(:role)
    end
end
