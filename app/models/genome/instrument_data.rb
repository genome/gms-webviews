class Genome::InstrumentData < ActiveRecord::Base
  self.table_name = 'instrument.data'
  self.inheritance_column = 'subclass_name'
  has_many :instrument_data_attributes
  belongs_to :library
end
