class Genome::Subject < ActiveRecord::Base
  self.table_name = "subject"
  self.inheritance_column = "subclass_name"
  self.primary_key = "subject_id"

  has_many :genome_models
  has_many :subject_attributes
  has_many :libraries, foreign_key: 'sample_id'

  scope :with_models_and_builds, includes(genome_models: [{builds: :master_event}, :model_inputs])
  scope :with_attributes, includes(:subject_attributes)
  scope :with_libraries, includes(:libraries)
end
