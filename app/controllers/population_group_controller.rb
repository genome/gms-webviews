class PopulationGroupController < ApplicationController
  def show
    Genome::PopulationGroup.find(params[:id])
  end
end
