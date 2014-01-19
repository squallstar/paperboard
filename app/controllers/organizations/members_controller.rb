class Organizations::MembersController < ApplicationController
  before_action :set_organization_member, only: [:show, :edit, :update, :destroy]

  # GET /organization_members
  # GET /organization_members.json
  def index
    @organization_members = OrganizationMember.all
  end

  # GET /organization_members/1
  # GET /organization_members/1.json
  def show
  end

  # GET /organization_members/new
  def new
    @organization_member = OrganizationMember.new
  end

  # GET /organization_members/1/edit
  def edit
  end

  # POST /organization_members
  # POST /organization_members.json
  def create
    @organization_member = OrganizationMember.new(organization_member_params)

    respond_to do |format|
      if @organization_member.save
        format.html { redirect_to @organization_member, notice: 'Organization member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_members/1
  # PATCH/PUT /organization_members/1.json
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

  # DELETE /organization_members/1
  # DELETE /organization_members/1.json
  def destroy
    @organization_member.destroy
    respond_to do |format|
      format.html { redirect_to organization_members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_member
      @organization_member = OrganizationMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_member_params
      params.require(:organization_member).permit(:role, :user_id, :organization_id)
    end
end
