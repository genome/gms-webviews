class GenomeModelController < ApplicationController
  def show
    @genome_model = Genome::GenomeModel.find(params[:id])
    @builds = @genome_model.builds.sorted_by_date_scheduled
    @last_complete_build = @builds.select {|b| b.master_event.event_status == 'Succeeded'}.first
    @inputs_by_name = @genome_model.inputs_by_name

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
