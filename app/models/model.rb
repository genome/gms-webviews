class Model < ActiveRecord::Base
  self.table_name = "model"
  has_and_belongs_to_many :model_groups, join_table: 'model_group_bridge'
  has_many :builds
  belongs_to  :processing_profile
  has_many :processing_profile_params, through: :processing_profile
  has_many :model_inputs
  belongs_to :subject
end
