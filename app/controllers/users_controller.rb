class UsersController < ApplicationController
  before_action :check_user, only: [:edit]
  before_action :set_user, only: [:show, :edit]

  # GET /users/1
  # GET /users/1.json
  def show
    @can_edit = params[:id] == @current_user.id
  end

  def edit
  end

  private
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'User not found.'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
