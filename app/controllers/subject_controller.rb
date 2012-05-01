class SubjectController < ApplicationController

  def show
    subject = Genome::Subject.where(subject_id: params[:id]).with_models_and_builds.with_attributes.with_libraries.first
    @subject = SubjectPresenter.new(subject)
  end

end
