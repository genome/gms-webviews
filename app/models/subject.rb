class Subject < ActiveRecord::Base
  set_table_name "subject"
  has_many :model
end
