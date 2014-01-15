class ProjectController < ApplicationController
  before_action :set_project

  def index
  end

  def members
    @members = @project.members.includes(:user)
  end
end
