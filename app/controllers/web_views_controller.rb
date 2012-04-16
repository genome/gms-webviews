class WebViewsController < ApplicationController
  def model_group
    @mg = ModelGroup.model_group_view(params[:id])
  end
end
