class ModelGroupsController < ApplicationController
  def show
    @mg = ModelGroup.model_group_view(params[:id])
  end
end
