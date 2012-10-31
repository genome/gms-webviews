class Genome::Subject < ActiveRecord::Base
  self.table_name = 'subject.subject'
  self.inheritance_column = "subclass_name"
  self.primary_key = "subject_id"

  has_many :models
  has_many :subject_attributes
  has_many :libraries, foreign_key: 'sample_id'

  scope :with_models_and_builds, includes(models: [{builds: :master_event}, :model_inputs])
  scope :with_attributes, includes(:subject_attributes)
  scope :with_libraries, includes(:libraries)

  def taxon
    find_subject_for_attribute_name "taxon_id"
  end

  def subject
    find_subject_for_attribute_name "source_id"
  end

  private
  def find_subject_for_attribute_name(subject_label)
    subject = self.subject_attributes.select{|a| a.attribute_label == subject_label}.first
    if subject
      Genome::Subject.find(subject.attribute_value)
    else
      nil
    end
  end
end
