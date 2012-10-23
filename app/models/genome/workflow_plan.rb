class Genome::WorkflowPlan < ActiveRecord::Base
  self.table_name = 'workflow.plan'
  self.primary_key = 'workflow_plan_id'

  def operations
    parsed_plan = Nokogiri::XML( self.xml )
    parse_operations_for_plan( parsed_plan )
  end

  private

    def legacy_staged_operations(parsed_plan)
      op_names = []
      operations = parsed_plan.xpath("//operation/operation[@name != 'merge results']")
      operations.each do |op|
        op_names.push op.attr("name")
      end
      by_names = Genome::WorkflowInstance.where(name: op_names).inject({}) {|h,i| h.tap{|h| h[i.name] = i}}
      return op_names.collect {|name| by_names[name]}
    end

    def workflow_only_operations(parsed_plan)
      workflow_name = parsed_plan.xpath("/workflow").attr("name").to_s
      parent_instance = Genome::WorkflowInstance.find_by_name(workflow_name)

      op_names = []
      operations = parsed_plan.xpath("//operation[@name != 'merge results']")

      operations.each do |op|
        op_names.push op.attr("name")
      end

      by_names = Genome::WorkflowInstance.where(name: op_names, parent_instance_id: parent_instance.id).inject({}) {|h,i| h.tap{|h| h[i.name] = i}}
      return op_names.collect {|name| by_names[name]}
    end

    def parse_operations_for_plan( parsed_plan )
      workflow_name = parsed_plan.xpath("/workflow").attr("name").to_s
      if workflow_name =~ /all stages$/
        return legacy_staged_operations(parsed_plan)
      else
        return workflow_only_operations(parsed_plan)
      end
    end
end
