class Genome::ModelLink < ActiveRecord::Base
  self.table_name = 'model.model_link'
  self.primary_keys = :to_model_id, :from_model_id
  has_one :from_model, class_name: 'Model', :primary_key => 'to_model_id', :foreign_key => 'genome_model_id'
  has_one :to_model, class_name: 'Model', :primary_key => 'from_model_id', :foreign_key => 'genome_model_id'
end



