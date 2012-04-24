class Library < ActiveRecord::Base
  self.table_name = 'fragment_library'
  self.primary_key = 'library_id'

  belongs_to :sample, class_name: "Subject", foreign_key: "sample_id"
end
