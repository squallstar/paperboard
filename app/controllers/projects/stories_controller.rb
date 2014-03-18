class Projects::StoriesController < ApplicationController
  include ProjectLoading

  before_action :load_project
  before_action :set_priorities, only: [:new, :create]
  before_action :set_story, only: [:destroy]

  def index
    @stories = @current_project.stories.includes(:owner)
  end

  def new
    @story = ProjectStory.new
  end

  def create
    @story = ProjectStory.new(story_params)
    @story.project = @current_project
    @story.owner = @current_user

    if @story.save
      redirect_to project_stories_path(@current_project), notice: 'Story was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
    @story = ProjectStory.where(id: params[:id]).includes(:comments, comments: :user).first

    unless @story
      redirect_to project_stories_path(@current_project), alert: 'Story not found'
    end
  end

  def destroy
    if @story.destroy
      redirect_to project_stories_path(@current_project)
    end
  end

  private

  def set_priorities
    @priorities = ProjectStory.priorities.invert
  end

  def set_story
    @story = ProjectStory.find params[:id]
  end

  def story_params
    params.require(:project_story).permit(:title, :body, :priority, :due_at)
  end
end