class Settings::ProfileController < ApplicationController
  before_action :set_user

  def index
  end

  def update
    Rails.cache.delete key_for_user_session(@current_user.id)

    if @user.update(user_params)
      redirect_to settings_profile_path, alert: 'Your profile was successfully updated.'
    else
      render action: 'index'
    end
  end

  private
    def set_user
      @user = User.find(@current_user)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
