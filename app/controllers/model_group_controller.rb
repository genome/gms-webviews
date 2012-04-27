class ModelGroupController < ApplicationController
  def show
    @mg = ModelGroupPresenter.new(params[:id])
  end
end
