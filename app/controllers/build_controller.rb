class BuildController < ApplicationController
  def show
    @build = Genome::Build.find(params[:id])
    @inputs = @build.build_inputs
  end
end
