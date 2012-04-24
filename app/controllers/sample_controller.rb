class SampleController < ApplicationController
  def show
    @sample = Genome::Sample.find(params[:id])
  end
end
