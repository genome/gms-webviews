class Genome::WorkflowInstanceExecution < ActiveRecord::Base
  self.table_name = 'workflow.instance_execution'
  self.primary_key = 'workflow_execution_id'
end
