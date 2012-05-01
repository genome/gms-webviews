class LibraryController < ApplicationController
  def show
    @library = Genome::Library.find_for_library_page(params[:id])
    @sample = @library.sample
    @models = @library.sample.models
    @taxon = @library.taxon
  end
end
