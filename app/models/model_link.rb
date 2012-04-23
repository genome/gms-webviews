class ModelLink < ActiveRecord::Base
  self.table_name = "model_link"
  has_one :from_model, class_name: 'GenomeModel', :primary_key => 'to_model_id', :foreign_key => 'genome_model_id'
  has_one :to_model, class_name: 'GenomeModel', :primary_key => 'from_model_id', :foreign_key => 'genome_model_id'
end



