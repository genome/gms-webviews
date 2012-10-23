class WorkflowController < ApplicationController

  def show
    workflow_instance = Maybe( Genome::WorkflowInstance.find( params[:id] ) )
    render partial: 'workflow_table', locals: { workflow_instance: workflow_instance }
  end

end
