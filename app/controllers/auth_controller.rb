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
    if params[:user]
      @user = User.new(signup_params)

      if @user.save
        AuthMailer.send_optin(@user)
        redirect_to signup_complete_path, flash: {
          email: @user.email, full_name: @user.full_name
        }
      end
    end
  end

  def signup_complete
    if not flash[:email]
      redirect_to login_url
    end
  end

  def signup_confirm_email
    @user = User.find(params[:id])

    if @user.optin_key == params[:key]
      # Enables the user
      @user.email_verified = true
      @user.is_active = true

      # Logs the user in
      session[:user_id] = @user.id

      # Send the welcome email
      AuthMailer.send_welcome(@user)
    else
      redirect_to login_path, alert: 'Confirmation key not valid'
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_url
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
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end