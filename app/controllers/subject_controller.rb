class SubjectController < ApplicationController
  def show
    @subject = Genome::Subject.with_models_and_builds.with_attributes.with_libraries.find(params[:id])
    @taxon = @subject.taxon if @subject.respond_to?(:taxon)

    case @subject
    when Genome::Sample
      @library = @subject.libraries.first
      render 'sample/show'
    when Genome::Individual
      render 'individual/show'
    when Genome::PopulationGroup
      render 'population_group/show'
    when Genome::Taxon
      render 'taxon/show'
    end

  end
end
