class Genome::ProcessingProfile < ActiveRecord::Base
  self.table_name = 'model.processing_profile'
  default_scope includes(:processing_profile_params)
  has_many :models
  has_many :processing_profile_params
  self.primary_key = 'id'

end
