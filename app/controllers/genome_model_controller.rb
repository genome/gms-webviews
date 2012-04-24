class GenomeModelController < ApplicationController
  def show
    @genome_model = Genome::GenomeModel.find(params[:id])
    @builds = @genome_model.builds.sorted_by_date_scheduled
    @last_complete_build = @builds.select {|b| b.master_event.event_status == 'Succeeded'}.first
    @inputs_by_name = @genome_model.inputs_by_name

    # Make a data structure that figures out the input differences between the model
    # and each of the builds

    # This is a hash of input IDs that are currently linked to the model
    inputs_for_this_model = @genome_model.model_inputs.inject({}) {
        |input_hash, model_input|
        input_hash["#{model_input.value_class_name}#{model_input.value_id}#{model_input.name}"] = model_input
        input_hash
    }

    @missing_inputs_for_build = @builds.inject({}) {
        |input_hash, build|

        # Start with all the inputs on the model and delete the ones attached to the build
        missing_build_inputs = inputs_for_this_model.dup
        build.build_inputs.each {
            |build_input|
            if ! missing_build_inputs.delete("#{build_input.value_class_name}#{build_input.value_id}#{build_input.name}")
                missing_build_inputs["#{build_input.value_class_name}#{build_input.value_id}#{build_input.name}"] = build_input
            end
        }
        # whatever is left are the inputs missing from this build
        input_hash[build.build_id] = missing_build_inputs
        input_hash
    }

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
