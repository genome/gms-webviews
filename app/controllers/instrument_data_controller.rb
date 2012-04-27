class InstrumentDataController < ApplicationController

  def show
    instrument_data = Genome::InstrumentData.find_for_instrument_data_page(params[:id])
    @instrument_data = InstrumentDataPresenter.new(instrument_data)
  end

end
