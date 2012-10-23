class Genome::WorkflowInstance < ActiveRecord::Base
  self.table_name = 'workflow.instance'
  self.primary_key = :workflow_instance_id

  belongs_to :parent_instance, :class_name=>'Genome::WorkflowInstance'
  has_many :child_instances, :class_name=>'Genome::WorkflowInstance', :foreign_key => :parent_instance_id
  
  belongs_to :plan, :class_name=>'Genome::WorkflowPlan', :foreign_key => :workflow_plan_id
end
