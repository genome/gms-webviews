class InstrumentDataController < ApplicationController

  def show
    @instrument_data = Genome::InstrumentData.find(params[:id])
    @attributes = @instrument_data.instrument_data_attributes
    @library = @instrument_data.library
    @taxon = @library.sample.taxon
  end

end
