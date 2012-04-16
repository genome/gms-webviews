class ModelInput < ActiveRecord::Base
  set_table_name "model_input"
  belongs_to :model
end
