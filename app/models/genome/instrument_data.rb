class Genome::InstrumentData < ActiveRecord::Base
  self.table_name = 'instrument.data'
  self.inheritance_column = 'subclass_name'
end
