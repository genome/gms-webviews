class Genome::WorkflowService < ActiveRecord::Base
  self.table_name = 'workflow.service'
  self.primary_keys = :hostname, :username, :process_id, :port, :start_time
end
