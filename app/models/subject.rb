class Subject < ActiveRecord::Base
  self.table_name = "subject"
  has_many :genome_models
  has_many :subject_attributes
  has_many :libraries, foreign_key: 'sample_id'

  scope :with_models_and_builds, includes(genome_models: [{builds: :master_event}, :model_inputs])
  scope :with_attributes, includes(:subject_attributes)
  scope :with_libraries, includes(:libraries)

  def taxon
    taxon_id = self.subject_attributes.select{|a| a.attribute_label == 'taxon_id'}.first
    if taxon_id
      Subject.where(subject_id: taxon_id.attribute_value).first if taxon_id
    else
      nil
    end
  end

end
