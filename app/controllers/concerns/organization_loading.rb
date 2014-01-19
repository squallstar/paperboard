module OrganizationLoading
  extend ActiveSupport::Concern

  def load_organization
    @organization = @current_user.organizations.find(params[:organization_id].to_i)
  end

  def is_admin
    @is_admin ||= OrganizationMember.select(:role).where(organization: @organization, user: @current_user, role: 'owner').count > 0
  end

  def require_admin
    if !is_admin
      redirect_to organization_members_url, notice: 'You have no rights to do this action'
    end
  end

end