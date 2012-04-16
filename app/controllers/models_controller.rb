class ModelsController < ApplicationController
  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @model }
      format.xml  { render xml: @model }
    end
  end
end
