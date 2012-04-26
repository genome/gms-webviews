class Genome::InstrumentDataAttribute < ActiveRecord::Base
  self.table_name = 'instrument.data_attribute'
  belongs_to :instrument_data
end
