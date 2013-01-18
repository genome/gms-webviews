class Genome::InstrumentDataAttribute < ActiveRecord::Base
  self.table_name = 'instrument.data_attribute'
  self.primary_keys = :instrument_data_id, :attribute_label, :attribute_value, :nomenclature
  belongs_to :instrument_data
end
