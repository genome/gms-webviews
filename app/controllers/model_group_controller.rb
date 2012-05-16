class ModelGroupController < ApplicationController

  def show
    id = params[:id] || params[:model_group_id]
    mg = Genome::ModelGroup.model_group_view(id) || not_found("Model group #{id} does not exist")
    @mg = ModelGroupPresenter.new(mg)
  end

  def convergence
    id = params[:model_group_id]
  end

  def coverage
    id = params[:model_group_id]
  end

end
