class Subject < ActiveRecord::Base
  self.table_name = "subject"
  has_many :genome_models
  #has_one :taxon
  #has_one :library

  scope :with_models_and_builds, includes(genome_models: [{builds: :master_event}, :model_inputs])
  #scope :with_taxon, includes(:taxon)
  #scope :with_library, includes(:library)
end
