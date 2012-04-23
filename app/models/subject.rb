class Subject < ActiveRecord::Base
  self.table_name = "subject"
  has_many :genome_models
  has_many :subject_attributes

  def taxon
    Subject.where(subject_id: self.subject_attributes.where(attribute_label: :taxon_id).first.attribute_value).first
  end

  scope :with_models_and_builds, includes(genome_models: [{builds: :master_event}, :model_inputs])
  #scope :with_taxon, includes(:taxon)
  #scope :with_library, includes(:library)
end
