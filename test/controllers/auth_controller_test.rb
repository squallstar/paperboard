require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should login when email/password are valid" do
    user = users(:default)
    post :login, email: user.email, password: 'secret'
    assert_redirected_to projects_url
    assert_equal user.id, session[:user_id]
  end


  test "should not login when email/password are not valid" do
    user = users(:default)
    post :login, email: 'hello', password: 'world'
    assert_nil session[:user_id]
    assert_template :login
  end

  test "should be redirected to the dashboard when accessed login and was logged in" do
    user = users(:default)
    post :login, email: user.email, password: 'secret'
    get :login
    assert_redirected_to projects_url
  end

  test "should get logout" do
    get :logout
    assert_nil session[:user_id]
    assert_redirected_to login_url
  end

end
