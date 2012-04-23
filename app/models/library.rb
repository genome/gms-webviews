class Library < ActiveRecord::Base
  self.table_name = 'fragment_library'
  self.primary_key = 'library_id'
end
