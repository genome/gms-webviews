module Genome
  module Extensions

    class NullObject
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
      obj.nil? ? NullObject.new : obj
    end

  end
end