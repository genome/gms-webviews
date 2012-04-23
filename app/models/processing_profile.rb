class ProcessingProfile < ActiveRecord::Base
  set_table_name "processing_profile"
  default_scope includes(:processing_profile_params)
  has_many :genome_models
  has_many :processing_profile_params
end
