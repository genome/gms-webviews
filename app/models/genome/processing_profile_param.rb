class Genome::ProcessingProfileParam < ActiveRecord::Base
  set_table_name "processing_profile_param"
  belongs_to :processing_profile
end
