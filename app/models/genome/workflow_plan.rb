class Genome::WorkflowPlan < ActiveRecord::Base
  self.table_name = 'workflow.plan'
  self.primary_key = 'workflow_plan_id'
  
end
