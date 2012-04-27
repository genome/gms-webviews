class BuildController < ApplicationController
  def show
    @build = BuildPresenter.new(params[:id])
  end
end
