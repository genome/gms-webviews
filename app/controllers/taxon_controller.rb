class TaxonController < ApplicationController
  def show
    @taxon = Genome::Taxon.find(params[:id])
  end
end
