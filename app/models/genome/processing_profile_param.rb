class Genome::ProcessingProfileParam < ActiveRecord::Base
  self.table_name = "processing_profile_param"
  belongs_to :processing_profile
end
