class TaxonController < ApplicationController
  def show
    @subject = SubjectPresenter.new(params[:id], controller: :taxon)
  end
end
