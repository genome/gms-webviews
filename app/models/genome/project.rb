class Genome::Project < ActiveRecord::Base
  self.table_name = 'subject.project'
  has_many :project_parts
  self.primary_key = :id
end
