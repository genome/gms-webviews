class BuildController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: BuildsDatatable.new(view_context) }
    end
  end

  def show
    build = Genome::Build.find(params[:id], include:[:master_event, model: [:processing_profile]])
    @build = BuildPresenter.new(build)
  end
end
