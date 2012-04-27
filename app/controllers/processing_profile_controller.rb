class ProcessingProfileController < ApplicationController
  def show
    @processing_profile = ProcessingProfilePresenter.new(params[:id])
  end
end
