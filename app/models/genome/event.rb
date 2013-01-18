class Genome::Event < ActiveRecord::Base
  self.table_name = 'model.event'
  belongs_to :build
  self.primary_key = :genome_model_event_id
end
