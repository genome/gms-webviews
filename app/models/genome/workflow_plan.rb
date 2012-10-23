class Genome::WorkflowPlan < ActiveRecord::Base
  self.table_name = 'workflow.plan'
  self.primary_key = 'workflow_plan_id'
  
  def operations
    parsed = Nokogiri(self.xml)

    op_names = []
    
    parsed.xpath("/operation").each do |op|
      #puts op.attr("name")
      op_names.push op.attr("name") unless op.attr("name") == "merge results"
    end
    
    Genome::WorkflowInstance.where(name: op_names)
  end
end
