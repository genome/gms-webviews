class ModelLink < ActiveRecord::Base
  self.table_name = "model_link"
  has_many :from_models, class_name: 'model', :primary_key => 'from_model_id'
  has_many :to_models, class_name: 'model', :primary_key => 'to_model_id'
end



