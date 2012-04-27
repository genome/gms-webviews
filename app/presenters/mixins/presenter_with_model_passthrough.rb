module Mixins
  module PresenterWithModelPassthrough
    def method_missing(meth, *args, &blk)
        model_object.send(meth, *args, &blk)
    rescue NoMethodError
        super
    end

    private
    def model_object
      raise 'must implement model_object'
    end
  end
end
