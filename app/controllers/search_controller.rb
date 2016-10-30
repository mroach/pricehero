class SearchController < ApplicationController
  def multi
    authorize :search, :multi?
    @query = params[:q]
    @results = PgSearch.multisearch @query
    respond_with @results
  end
end
