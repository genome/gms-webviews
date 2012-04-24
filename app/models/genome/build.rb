class Genome::Build < ActiveRecord::Base
    self.table_name = "build"
    scope :sorted_by_date_scheduled, includes(:master_event).joins(:master_event).order('date_scheduled')
    belongs_to :model
    has_one :model, class_name: "GenomeModel", foreign_key: :genome_model_id, primary_key: :model_id
    has_one :master_event, class_name: :Event, conditions: ["event_type = 'genome model build'"]
end