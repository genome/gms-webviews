class Genome::WorkflowInstance < ActiveRecord::Base
  self.table_name = 'workflow.instance'
  self.primary_key = :workflow_instance_id

  has_one    :execution, :class_name=>'Genome::WorkflowInstanceExecution', :foreign_key => :workflow_instance_id
  has_many   :child_operations, :class_name=>'Genome::WorkflowInstance', :foreign_key => :parent_instance_id
  has_many   :child_instances, :class_name=>'Genome::WorkflowInstance', :foreign_key => :parent_execution_id, :primary_key => :current_execution_id
  belongs_to :plan, :class_name=>'Genome::WorkflowPlan', :foreign_key => :workflow_plan_id
  belongs_to :parent, :class_name=>'Genome::WorkflowInstance'

  delegate :status, :start_time, :end_time, :dispatch_id, :stdout, :stderr,  to: :execution

  def elapsed_time
    end_time - start_time
  end
end
