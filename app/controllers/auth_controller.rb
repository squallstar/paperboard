class AuthController < ApplicationController
  skip_before_action :authorize
  before_action :check_if_logged_in, only: [:login, :signup]
  layout "forms"

  def login
    if params[:email]
      user = User.find_by(email: params[:email])
      p user
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to session[:return_to] || root_url
        session.delete(:return_to)
      else
        flash.now[:alert] = 'Invalid email/password combination'
      end
    end
  end

  def signup
    @user = User.new

    if params[:method] == 'POST'
      @user = User.new(signup_params)
    end
  end

  def logout
    session.destroy
    redirect_to login_url, notice: "Logged out"
  end

  def redirect_after_login
    redirect_to root_url
  end

  def check_if_logged_in
    if session[:user_id]
      redirect_to root_url
    end
  end

  def signup_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end