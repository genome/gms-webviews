class Genome::Model < ActiveRecord::Base
  self.table_name = "model"
  self.primary_key = 'genome_model_id'
  has_and_belongs_to_many :model_groups, foreign_key: 'model_id', join_table: 'model_group_bridge'
  has_many :builds, foreign_key: 'model_id'
  belongs_to  :processing_profile
  has_many :processing_profile_params, through: :processing_profile
  has_many :model_inputs, foreign_key: 'model_id'
  belongs_to :subject
  has_many :from_model_links, :class_name => 'ModelLink', foreign_key: 'from_model_id'
  has_many :to_model_links, :class_name => 'ModelLink', foreign_key: 'to_model_id'
#  has_many :child_linked_models, class_name: 'genome_model', foreign_key: 'from_model_id', join_table: 'model_link'
#  has_many :parent_linked_models, class_name: 'genome_model', foreign_key: 'to_model_id', join_table: 'model_link'

  def inputs_by_name
    self.model_inputs.inject({}) do |by_name, input|
      by_name[input.name] = [] unless by_name[input.name]
      by_name[input.name] << input
      by_name
    end
  end

  class << self
    def find_for_model_page(id)
      where(genome_model_id: id).includes(:model_inputs, to_model_links: [:to_model], from_model_links: [:to_model], builds: [:build_inputs, :master_event]).first
    end
  end

end


