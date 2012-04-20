class SearchController < ApplicationController
  def search_results
    if params[:q]
      results = SolrSearch.search(params)
      @docs = results.docs
      @query = params[:q]
      @facets = results.facets
      @facet = params[:fq]
    else
      render :search
    end
  end
end
