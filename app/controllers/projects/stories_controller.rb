class Projects::StoriesController < ApplicationController
  include ProjectLoading

  before_action :load_project

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

  def destroy
    story = Story.find(params[:id])

    if story.destroy
      redirect_to project_stories_path(@current_project)
    end
  end

  private

  def story_params
    params.require(:project_story).permit(:title, :body)
  end
end