class Settings::AccountController < ApplicationController
  before_action :set_user

  def index
  end

  def update
    if @user.update_with_password(user_params)
      Rails.cache.delete key_for_user_session(@current_user.id)
      @current_user = @user

      flash.now[:alert] = 'Your account was successfully updated.'
    end

    render action: 'index'
  end

  private
    def set_user
      @user = User.find(@current_user)
    end

    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end