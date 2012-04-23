class Build < ActiveRecord::Base
  set_table_name :build
  belongs_to :model
  has_one :model, class_name: "GenomeModel", foreign_key: :genome_model_id, primary_key: :model_id
  has_one :master_event, class_name: :Event, conditions: ["event_type = 'genome model build'"]
end
