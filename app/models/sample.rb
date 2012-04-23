class Sample < ActiveRecord::Base
  self.table_name = 'subject'
  has_many :genome_models, foreign_key: 'subject_id'

  scope :with_models_and_builds, includes(genome_models: [{builds: :master_event}, :model_inputs])
end
