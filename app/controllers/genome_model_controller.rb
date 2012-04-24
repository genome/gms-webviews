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
        input_hash["#{model_input.name}"] = model_input
        input_hash
    }

    @delta_inputs_for_build = @builds.inject({}) {
        |input_hash, build|

        # Start with all the inputs on the model and delete the ones attached to the build
        inputs_only_on_model = inputs_for_this_model.dup
        different_build_inputs = Hash.new
        inputs_only_on_build = Hash.new
        build.build_inputs.each {
            |build_input|
            
            if inputs_for_this_model[build_input.name]
                if inputs_for_this_model[build_input.name].value_id != build_input.value_id
                    # It exists on the model but has a different  value
                    different_build_inputs[build_input.name] = build_input
                end
                inputs_only_on_model.delete("#{build_input.name}");
            else
                # This input exists on the build but not the model
                inputs_only_on_build[build_input.name] = build_input
            end
        }
        # whatever is left are the inputs missing from this build
        input_hash[build.build_id] = Hash.new
        input_hash[build.build_id]['only_on_model'] = inputs_only_on_model
        input_hash[build.build_id]['only_on_build'] = inputs_only_on_build;
        input_hash[build.build_id]['different'] = different_build_inputs;
        input_hash
    }

    respond_to do |format|
      format.html
      format.json { render json: @genome_model }
      format.xml  { render xml: @genome_model }
    end
  end
end
