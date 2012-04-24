class BuildController < ApplicationController
  def show
    @build = Genome::Build.find(params[:id])
  end
end
