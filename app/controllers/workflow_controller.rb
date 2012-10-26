class WorkflowController < ApplicationController

  def show
    workflow_instance = Maybe( Genome::WorkflowInstance.joins(:plan).includes(:plan).find( params[:id] ) )
    render partial: 'workflow_table', locals: { workflow_instance: workflow_instance }
  end

end
