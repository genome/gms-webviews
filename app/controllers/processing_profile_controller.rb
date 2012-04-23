class ProcessingProfileController < ApplicationController
  def show
    @processing_profile = ProcessingProfile.find(params[:id])
  end
end
