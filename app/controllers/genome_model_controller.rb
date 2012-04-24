class GenomeModelController < ApplicationController
  def show
    @genome_model = Genome::GenomeModel.find(params[:id])
    @builds = @genome_model.builds
    @most_recent_completed = (@genome_model.builds.select{|build| build.master_event.event_status == 'Succeeded'}).first

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
