module OrganizationLoading
  extend ActiveSupport::Concern

  def load_organization
    id = params[:organization_id] || params[:id]
    @organization = @current_user.organizations.find(id.to_i)

  rescue ActiveRecord::RecordNotFound
    redirect_to organizations_path, alert: 'That organization does not exist or you don\'t have the rights to see it.'
  end

  def is_admin
    @is_admin ||= OrganizationMember.select(:role).where(organization: @organization, user: @current_user, role: 'owner').count > 0
  end

  def require_admin
    if !is_admin
      redirect_to organization_members_url, alert: 'You have no rights to do this action'
    end
  end

end