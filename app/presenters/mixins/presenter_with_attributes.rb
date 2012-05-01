module Mixins
  module PresenterWithAttributes

    def each_attribute(context)
      attribute_pairs.each_pair do |name, value|
        yield name, value.respond_to?(:call) ? context.instance_exec(model_object, &value) : value
      end
    end

    private
    #Attribute pairs should return a Hash where each key is the value
    #that you want to appear as the "name" or "term" in the dictionary
    #tag, and each value should be either a string object representing
    #what you want to render out or a lambda that accepts a single
    #arugment which is the return value of "model_object"
    #The result of calling this lambda will be inserted
    #into the definition tag
    def attribute_pairs
      raise "Must implement attribute_pairs"
    end

    def model_object
      raise "Must implement model_object"
    end

  end
end
