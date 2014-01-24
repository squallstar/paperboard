class V1::SuggestionsController < ApplicationController
  before_filter :set_query

  def people

    @colleagues = @current_user.colleagues.where("username LIKE :username OR full_name LIKE :full_name", username: @query, full_name: "%#{@query}")
    @siblings = @current_user.siblings.where("username LIKE :username OR full_name LIKE :full_name", username: @query, full_name: "%#{@query}")

    people = (@colleagues + @siblings).uniq{ |user| user.id }

    render json: people
  end

  private
    def set_query
      @query = "#{params[:query]}%"
    end
end
