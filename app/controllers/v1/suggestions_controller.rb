class V1::SuggestionsController < ApplicationController
  before_filter :set_query

  def people

    @colleagues = @current_user.colleagues.where("full_name ILIKE :query", query: @query)
    @siblings = @current_user.siblings.where("full_name ILIKE :query", query: @query)

    people = (@colleagues + @siblings).uniq{ |user| user.id }

    render json: people
  end

  private
    def set_query
      @query = "%#{params[:query]}%"
    end
end
