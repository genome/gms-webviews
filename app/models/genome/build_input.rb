class Genome::BuildInput < ActiveRecord::Base

    self.table_name = 'model.build_input'
    belongs_to :build

    def get_input_value_internal
        if self.value_class_name.include?("Genome::Model::Build")
            return Genome::Build.find(self.value_id)
        elsif self.value_class_name.include?("Genome::InstrumentData")
            return Genome::InstrumentData.find(self.value_id)
        else
            return self.id
        end
    end

    def get_input_value
        @value ||= self.get_input_value_internal()
    end

    def method_missing(meth, *args, &blk)
        build.send(meth, *args, &blk)
    rescue NoMethodError
        super
    end

end
