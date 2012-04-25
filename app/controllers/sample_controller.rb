class SampleController < ApplicationController
  def show
    @subject = Genome::Sample.find(params[:id], include: [ models: {builds: :build_inputs} ] )
    @taxon = @subject.taxon
    @library = @subject.libraries.first
  end
end
