class Event < ActiveRecord::Base
  set_table_name 'event'
  belongs_to :build
end
