class ModelGroupController < ApplicationController
  def show
    @mg = Genome::ModelGroup.model_group_view(params[:id])
  end
end
