class Genome::Build < ActiveRecord::Base
    self.table_name = 'model.build'
    scope    :sorted_by_date_scheduled, includes(:master_event).joins(:master_event).order('date_scheduled')
    has_many :build_inputs, foreign_key: :build_id
    has_many :events, foreign_key: :build_id
    has_one  :model, class_name: "Model", foreign_key: :genome_model_id, primary_key: :model_id
    has_one  :master_event, class_name: :Event, conditions: ["event_type = 'genome model build'"]

    def workflow_instance
      Genome::WorkflowInstance.where('name like :build_id', build_id: "#{self.id}%").first
    end

end
