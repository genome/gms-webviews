class Build < ActiveRecord::Base
  set_table_name "build"
  belongs_to :model
  has_one :master_event, class_name: "Event", conditions: ["event_type = 'genome model build'"]
end
