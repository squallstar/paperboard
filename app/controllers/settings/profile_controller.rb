class Settings::ProfileController < ApplicationController
  before_action :set_user

  def index
  end

  def update
    if @user.update(user_params)
      @current_user = @user

      flash.now[:alert] = 'Your profile was successfully updated.'
    end

    render action: 'index'
  end

  private
    def set_user
      @user = User.find(@current_user)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :avatar)
    end
end
