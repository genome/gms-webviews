class Genome::Event < ActiveRecord::Base
  self.table_name = 'model.event'
  belongs_to :build
end
