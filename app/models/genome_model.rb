class GenomeModel < ActiveRecord::Base
  self.table_name = "model"
  has_and_belongs_to_many :model_groups, foreign_key: 'model_id', join_table: 'model_group_bridge'
  has_many :builds, foreign_key: 'model_id'
  belongs_to  :processing_profile
  has_many :processing_profile_params, through: :processing_profile
  has_many :model_inputs, foreign_key: 'model_id'
  belongs_to :subject
end



