require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a project" do
    project = projects(:one)
    post :create, name: project.name
    assert_redirected_to projects_url
  end

end
