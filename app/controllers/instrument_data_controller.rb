class InstrumentDataController < ApplicationController

  def show
    @instrument_data = Genome::InstrumentData.find(params[:id])
    case @instrument_data
    when Genome::InstrumentData::Solexa
      render 'instrument_data/solexa/show'
    when Genome::InstrumentData::Sanger
      render 'instrument_data/sanger/show'
    when Genome::InstrumentData::Imported
      render 'instrument_data/imported/show'
  #  when Genome::InstrumentData::454
  #    render 'instrument_data/454/show'
    end
  end

end
