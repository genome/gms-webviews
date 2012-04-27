class BuildController < ApplicationController
  def show
    build = Genome::Build.find(params[:id], include:[:master_event, model: [:processing_profile]])
    @build = BuildPresenter.new(build)
  end
end
