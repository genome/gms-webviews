class ModelGroupController < ApplicationController
  def show
    id = params[:id] || params[:model_group_id]
    mg = Genome::ModelGroup.model_group_view(id)
    @mg = ModelGroupPresenter.new(mg)
  end

end
