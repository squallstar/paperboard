class V1::SuggestionsController < ApplicationController
  before_filter :set_query

  def people

    @colleagues = @current_user.colleagues.where_name_like(@query).select(:id, :full_name)
    @siblings = @current_user.siblings.where_name_like(@query).select(:id, :full_name)

    people = (@colleagues + @siblings).uniq{ |user| user.id }

    render json: people, root: "people"
  end

  private
    def set_query
      @query = "#{params[:query]}%".downcase
    end
end
