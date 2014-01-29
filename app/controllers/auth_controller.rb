class AuthController < ApplicationController
  skip_before_action :authorize
  before_action :check_if_logged_in, only: [:login, :signup, :forgot_password]
  layout "forms"

  def login
    if params[:email]
      user = User.find_by(email: params[:email])
      p user
      if user and user.authenticate(params[:password])
        logs_and_redirect(user)
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
        # Sends the email and redirect
        AuthMailer.confirm_email(@user).deliver
        redirect_to signup_complete_path, flash: {
          email: @user.email, full_name: @user.full_name
        }
      end
    end
  end

  def forgot_password
    if params[:email]
      user = User.find_by_email(params[:email])

      if user
        # Send reset password email
        AuthMailer.reset_password(user).deliver

        # Redirect to thank you page
        @email = user.email
        render "forgot_password_sent"
      else
        flash.now[:alert] = 'Email address not registered'
      end
    end
  end

  def reset_password
    @user = User.find(params[:id])

    if @user.request_token != params[:request_token]
      return redirect_to forgot_password_path, alert: 'Invalid key. Please request a new reset password email.'
    end

    if params[:user] && params[:password]
      reset_password_params[:request_token] = nil

      if @user.update(reset_password_params)
        redirect_to login_path, alert: 'Your password has been updated!'
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

    if @user.optin_key == params[:key] && @user.email_verified = false
      # Enables the user
      @user.email_verified = true
      @user.is_active = true

      # Joins any pending project
      @user.join_pending_invites

      # Logs the user in
      session[:user_id] = @user.id

      # Send the welcome email
      AuthMailer.welcome(@user).deliver

      logger.info "Email confirmed for user ##{user.id} #{user.email}"
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

  private
    def check_if_logged_in
      if session[:user_id]
        redirect_to root_url
      end
    end

    def logs_and_redirect(user)
      session[:user_id] = user.id

      redirect_to session[:return_to] || dashboard_url
      session.delete(:return_to)
    end

    def signup_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end

    def reset_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end