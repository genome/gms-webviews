class ModelGroup < ActiveRecord::Base
  set_table_name "model_group"
  has_and_belongs_to_many :genome_models, association_foreign_key: 'model_id', join_table: 'model_group_bridge'

  def self.model_group_view(id)
    where(id: id).includes(:genome_models => [:processing_profile, :processing_profile_params, :subject, {:builds => [:master_event]}, :model_inputs]).first
  end

end
