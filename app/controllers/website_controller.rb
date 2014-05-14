class WebsiteController < ApplicationController
  skip_before_action :authorize
  before_action :check_auth
  layout 'website'

  def index
  end

  private
  def check_auth
    if session[:user_id]
      redirect_to dashboard_path
    end
  end
end
