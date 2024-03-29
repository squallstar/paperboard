module OrganizationLoading
  extend ActiveSupport::Concern

  def load_organization
    id = (params[:organization_id] || params[:id]).to_i
    @organization = @current_user.cached_organizations.find { |o| o.id == id }
    unless @organization
      redirect_to organizations_path, alert: 'That organization does not exist or you don\'t have the rights to see it.'
    end
    @organization
  end

  def is_admin
    if @is_admin
      return @is_admin
    end

    team = @current_user.cached_teams.find do |t|
      t.organization_id == @organization.id && (t.role == 'owner' || t.role == 'admin')
    end

    @is_admin ||= team
  end

  def require_admin
    unless is_admin
      redirect_to organizations_path, alert: 'You have no rights to do this action'
    end
  end
end
