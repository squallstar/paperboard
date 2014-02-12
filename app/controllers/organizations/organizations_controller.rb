class Organizations::OrganizationsController < ApplicationController
  include OrganizationLoading

  before_action :load_organization, except: [:index, :new, :create]
  before_action :is_admin, only: [:members]
  before_action :require_admin, only: [:update, :destroy, :remove_member]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = @current_user.cached_organizations
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new_with_user(organization_params, @current_user)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: "Organization #{@organization.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization #{@organization.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: "Organization #{@organization.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def members
    @users = @organization.users
  end

  def remove_member
    user = User.select(:id, :full_name).find(params[:user])
    if @organization.remove_user(user)
      if user == @current_user
        redirect_to organizations_path, notice: "You just left the organization #{@organization.name}."
      else
        redirect_to members_organization_path(@organization), notice: "#{user.full_name} was successfully removed from the organization #{@organization.name}."
      end
    else
      redirect_to members_organization_path(@organization), alert: "We couldn't do that. Please try later."
    end
  end

  def join_team
    #Todo
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
