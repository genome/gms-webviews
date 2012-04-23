class SubjectAttribute < ActiveRecord::Base
  self.table_name = 'subject_attribute'
  belongs_to :subject, foreign_key: 'subject_id'
end
