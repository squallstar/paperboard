class V1::SuggestionsController < ApplicationController
  before_filter :set_query

  def people

    @people = @current_user.colleagues.where("username LIKE :username OR full_name LIKE :full_name", username: @query, full_name: "%#{@query}")

    render json: @people
  end

  private
    def set_query
      @query = "#{params[:query]}%"
    end
end
