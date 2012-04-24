class SubjectController < ApplicationController
  def show
    @subject = Genome::Subject.with_models_and_builds.with_attributes.with_libraries.find(params[:id])
    @library = @subject.libraries.first
    @taxon = @subject.taxon
  end
end
