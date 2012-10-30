class ProcessingProfileController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: ProcessingProfilesDatatable.new(view_context) }
    end
  end
  
  
  def show
    processing_profile =  Genome::ProcessingProfile.find(params[:id], include: :processing_profile_params)
    @processing_profile = ProcessingProfilePresenter.new(processing_profile)
  end
end
