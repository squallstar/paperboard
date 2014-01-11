class AuthController < ApplicationController
  layout "forms"

  def login
    if params[:email]
      user = User.find_by(email: params[:email])
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        #redirect_to admin_url
      else
        flash.now[:alert] = 'Invalid email/password combination'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to auth_login_url, notice: "Logged out"
  end
end
