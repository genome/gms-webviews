class Genome::Event < ActiveRecord::Base
  self.table_name = 'event'
  belongs_to :build
end
