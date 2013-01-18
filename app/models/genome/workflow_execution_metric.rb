class Genome::WorkflowExecutionMetric < ActiveRecord::Base
  self.table_name = 'workflow.execution_metric'
  self.primary_key = :workflow_execution_id
end
