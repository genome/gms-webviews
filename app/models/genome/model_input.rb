class Genome::ModelInput < ActiveRecord::Base
  self.table_name = 'model.model_input'
  default_scope include: :build
  belongs_to :model
  has_one :build, primary_key: 'value_id', foreign_key: "build_id"
 
  self.primary_keys = :model_id, :value_id, :value_class_name, :name

  def method_missing(meth, *args, &blk)
    build.send(meth, *args, &blk)
  rescue NoMethodError
    super
  end

end
