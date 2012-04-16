class ProcessingProfile < ActiveRecord::Base
  set_table_name "processing_profile"
  has_many :models
  has_many :processing_profile_params
end
