class Settings::AccountController < ApplicationController
  before_action :set_user

  def index
  end

  def update
    if @user.update_with_password(user_params)
      @current_user = @user

      flash.now[:notice] = 'Your account was successfully updated.'
    end

    render action: 'index'
  end

  def destroy
    User.find(@current_user).destroy
    redirect_to logout_path
  end

  private
  def set_user
    @user = User.find(@current_user)
    @owns_organizations = @user.teams.where(role: 'admin').count > 0
  end

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
