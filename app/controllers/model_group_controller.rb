class ModelGroupController < ApplicationController
  def show
    mg = Genome::ModelGroup.model_group_view(params[:id])
    @mg = ModelGroupPresenter.new(mg)
  end
end
