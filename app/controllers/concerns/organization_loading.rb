module OrganizationLoading
  extend ActiveSupport::Concern

  def load_organization
    id = (params[:organization_id] || params[:id]).to_i
    @organization = @current_user.cached_organizations.find { |o| o.id == id }
    if not @organization
      redirect_to organizations_path, alert: 'That organization does not exist or you don\'t have the rights to see it.'
    end
    @organization
  end

  def is_admin
    # to be changed with teams
    @is_admin ||= OrganizationMember.select(:role).where(organization: @organization, user: @current_user, role: 'owner').count > 0
  end

  def require_admin
    if !is_admin
      redirect_to organization_members_url, alert: 'You have no rights to do this action'
    end
  end

end