class TaxonController < ApplicationController
  def show
    @subject = Genome::Taxon.find(params[:id])
  end
end
