class ProcessingProfileController < ApplicationController
  def show
    processing_profile =  Genome::ProcessingProfile.find(params[:id], include: :processing_profile_params)
    @processing_profile = ProcessingProfilePresenter.new(processing_profile)
  end
end
