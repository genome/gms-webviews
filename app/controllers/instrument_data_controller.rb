class InstrumentDataController < ApplicationController

  def show
    @instrument_data = Genome::InstrumentData.find(params[:id])
    @attributes = @instrument_data.instrument_data_attributes
    @library = @instrument_data.library
    #taxon could be on the library's sample, or one level higher
    #if there is a population group or individual record
    @taxon = @library.sample.taxon
    @taxon = @library.sample.subject.taxon unless @taxon
  end

end
