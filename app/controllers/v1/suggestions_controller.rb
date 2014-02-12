class V1::SuggestionsController < ApplicationController
  layout false
  before_filter :set_query

  def people

    @colleagues = @current_user.colleagues.where_name_like(@query).select(:id, :full_name)
    @siblings = @current_user.siblings.where_name_like(@query).select(:id, :full_name)

    @people = (@colleagues + @siblings).uniq{ |user| user.id }

    respond_to do |format|
      format.json { render json: @people, root: "people" }
      format.html { render }
    end
  end

  private
    def set_query
      @query = "#{params[:query]}%".downcase
    end
end
