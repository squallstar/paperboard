class Settings::OrganizationsController < ApplicationController
  include OrganizationLoading

  before_action :load_organizations, only: [:index]
  before_action :load_organization, only: [:leave]

  def index
  end

  def leave
    if @organization.remove_user(@current_user)
      flash.notice = "You left the organization #{@organization.name}"
      redirect_to action: 'index'
    end
  end

  private
    def load_organizations
      @organizations = @current_user.cached_organizations
    end
end