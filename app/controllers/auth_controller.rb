class AuthController < ApplicationController
  skip_before_action :authorize
  layout "forms"

  def login
    if params[:email]
      user = User.find_by(email: params[:email])
      p user
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_after_login
      else
        flash.now[:alert] = 'Invalid email/password combination'
      end
    elsif session[:user_id]
      redirect_after_login
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end

  def redirect_after_login
    redirect_to projects_url
  end
end
