class Genome::SubjectAttribute < ActiveRecord::Base
  self.table_name = 'subject.subject_attribute'
  belongs_to :subject, foreign_key: 'subject_id'
  self.primary_key = :subject_id, :attribute_label, :attribute_value, :nomenclature
end
