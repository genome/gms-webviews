class InstrumentDataController < ApplicationController

  def show
    @instrument_data = Genome::InstrumentData.find_for_instrument_data_page(params[:id])
    @attributes = @instrument_data.instrument_data_attributes
    @library = @instrument_data.library
    @taxon = @library.taxon
  end

end
