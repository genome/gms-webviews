module Mixins
  module PresenterWithAttributes
    def each_attribute
      attribute_pairs.each_pair do |name, value|
        yield name, value.respond_to?(:call) ? value.call(model_object) : value
      end
    end

    private
    def attribute_pairs
      raise "Must implement attribute_pairs"
    end

    def model_object
      raise "Must implement model_object"
    end
  end
end
