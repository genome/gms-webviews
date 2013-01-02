class Genome::ModelGroup < ActiveRecord::Base
  self.table_name =  'model.model_group'
  has_and_belongs_to_many :models, association_foreign_key: 'model_id', join_table: 'model_group_bridge'

  def self.model_group_view(id)
    where(id: id).first
  end

end
