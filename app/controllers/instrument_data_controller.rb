class InstrumentDataController < ApplicationController

  def show
    @instrument_data = InstrumentDataPresenter.new(params[:id])
  end

end
