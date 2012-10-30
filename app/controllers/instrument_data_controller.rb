class InstrumentDataController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: InstrumentDataDatatable.new(view_context) }
    end
  end

  def show
    instrument_data = Genome::InstrumentData.find_for_instrument_data_page(params[:id])
    @instrument_data = InstrumentDataPresenter.new(instrument_data)
  end

end
