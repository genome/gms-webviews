class Genome::WorkflowInstance < ActiveRecord::Base
  self.table_name = 'workflow.instance'
  self.primary_key = :workflow_instance_id

  has_one    :execution, :class_name=>'Genome::WorkflowInstanceExecution', :foreign_key => :workflow_instance_id
  has_many   :child_operations, :class_name=>'Genome::WorkflowInstance', :foreign_key => :parent_instance_id
  has_many   :child_instances, :class_name=>'Genome::WorkflowInstance', :foreign_key => :parent_execution_id, :primary_key => :current_execution_id
  has_many   :peers, :class_name=>'Genome::WorkflowInstance', :foreign_key => :peer_instance_id
  belongs_to :plan, :class_name=>'Genome::WorkflowPlan', :foreign_key => :workflow_plan_id
  belongs_to :parent, :class_name=>'Genome::WorkflowInstance'

  delegate :status, :start_time, :end_time, :dispatch_id, :stdout, :stderr,  to: :execution

  def elapsed_time
    end_time - start_time
  end

  def self.tree_for(instance)
      where("#{table_name}.#{primary_key} IN (#{tree_sql_for(instance)})").order("#{table_name}.#{primary_key}")
  end

  def self.tree_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(#{primary_key}, path) AS (
          SELECT #{primary_key}, ARRAY[]::character varying[]
          FROM #{table_name}
          WHERE #{primary_key} = '#{instance.id}'
        UNION ALL
          SELECT #{table_name}.#{primary_key}, path || #{table_name}.#{primary_key}
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_instance_id = search_tree.#{primary_key} 
          WHERE NOT #{table_name}.#{primary_key} = ANY(path)
      )
      SELECT #{primary_key} FROM search_tree ORDER BY path
    SQL
  end

end
