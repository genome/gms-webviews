class GenomeModelController < ApplicationController
  def show
    @genome_model = GenomeModel.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
