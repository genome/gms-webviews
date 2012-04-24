class IndividualController < ApplicationController
  def show
    @individual = Genome::Individual.find(params[:id])
  end
end
