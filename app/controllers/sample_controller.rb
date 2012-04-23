class SampleController < ApplicationController
  def show
    @sample = Sample.with_models_and_builds.find(params[:id])
  end
end
