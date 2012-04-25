class BuildController < ApplicationController
  def show
    @build = Genome::Build.find(params[:id])
    @inputs = @build.build_inputs
    @events = @build.events
    @inputs.each { |i|
        i.get_input_value
    } 
  end
end
