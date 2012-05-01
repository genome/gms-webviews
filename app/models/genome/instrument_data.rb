class Genome::InstrumentData < ActiveRecord::Base
  self.table_name = 'instrument.data'
  self.inheritance_column = 'subclass_name'
  has_many :instrument_data_attributes
  belongs_to :library

  class << self
    def find_for_instrument_data_page(id)
      where(id: id ).includes( library: [:sample]).first
    end
  end
end
