class ProcessingProfileController < ApplicationController
  def show
    @processing_profile = Genome::ProcessingProfile.find(params[:id])
  end
end
