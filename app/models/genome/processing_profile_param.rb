class Genome::ProcessingProfileParam < ActiveRecord::Base
  self.table_name = 'model.processing_profile_param'
  belongs_to :processing_profile
  self.primary_keys = :processing_profile_id, :param_name, :param_value
end
