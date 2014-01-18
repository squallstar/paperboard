class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_username(params[:username])
      if not @user
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username)
    end
end
