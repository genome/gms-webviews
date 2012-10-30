class SubjectController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: SubjectsDatatable.new(view_context) }
    end
  end

  def show
    subject = Genome::Subject.where(subject_id: params[:id]).with_models_and_builds.with_attributes.with_libraries.first
    @subject = SubjectPresenter.new(subject)
  end

end
