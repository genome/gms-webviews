class Genome::BuildInput < ActiveRecord::Base

  self.table_name = "build_input"
  belongs_to :build

  def method_missing(meth, *args, &blk)
    build.send(meth, *args, &blk)
  rescue NoMethodError
    super
  end

end
