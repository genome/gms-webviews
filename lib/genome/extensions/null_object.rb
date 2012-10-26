module Genome
  module Extensions

    class NullObject
      include Singleton

      def method_missing(name, *args)
        self
      end

      def nil?
        true
      end

      def inspect
        ''
      end

      def to_s
        ''
      end
    end

    def Maybe(obj)
      obj.nil? ? NullObject.instance : obj
    end

  end
end