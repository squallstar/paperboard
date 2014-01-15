class ProjectController < ApplicationController
  before_action :current_project

  def index
  end

  def members
    @members = @project.members.includes(:user)
  end
end