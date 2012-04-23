class GenomeModelController < ApplicationController
  def show
    @genome_model = GenomeModel.find(params[:id])
    @builds = @genome_model.builds.sorted_by_date_scheduled
    @most_recent_succeeded_build = @builds.select {|b| b.master_event.event_status == 'Succeeded'}.first

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
