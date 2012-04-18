class Subject < ActiveRecord::Base
  set_table_name "subject"
  has_many :genome_models
end
