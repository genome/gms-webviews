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
      by_names = Genome::WorkflowInstance
        .where(name: op_names)
        .inject({}) {|h,i| h.tap{|h| h[i.name] = i}}
      return op_names.collect {|name| by_names[name]}
    end

    def workflow_only_operations(parsed_plan)
      parent_instance = Genome::WorkflowInstance
        .where(parent_instance_id: nil, workflow_plan_id: self.id).first
      if parent_instance.peer_instance_id
        parent_instance = Genome::WorkflowInstance
          .find(parent_instance.peer_instance_id)
      end

      op_names = []
      operations = parsed_plan.xpath("//operation[operationtype/@commandClass]")

      operations.each do |op|
        op_names.push op.attr("name")
      end

      by_names = Genome::WorkflowInstance
        .tree_for( parent_instance  )
        .inject(Hash.new {|h,k| h[k] = []}) do |h, i|
          h.tap do |h|
            h[i.name].concat [i]
          end
        end

      out = []

      op_names.each do |name|
        out.concat by_names[name]
        out.concat by_names[name].flat_map {|op| op.peers.all}
      end

      return out.uniq_by {|obj| obj.id}
    end

    def parse_operations_for_plan( parsed_plan )
      workflow_node = parsed_plan.xpath("/workflow")
      if workflow_node.any? && workflow_node.attr("name").to_s =~ /all stages$/
        return legacy_staged_operations(parsed_plan)
      else
        return workflow_only_operations(parsed_plan)
      end
    end

end
