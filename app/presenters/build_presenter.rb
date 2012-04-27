class BuildPresenter
  include Mixins::PresenterWithAttributes
  include Mixins::PresenterWithModelPassthrough

  def initialize(id)
    @build = Genome::Build.find(id, include:[:master_event, model: [:processing_profile]])
  end

  def model
    @model ||= @build.model
  end

  def model_name
    model.name
  end

  def inputs
    unless @inputs
      inputs = @build.build_inputs
      inputs.each{|i| i.get_input_value }
      @inputs = BuildInputsPresenter.new(inputs)
    end
    @inputs
  end

  def events
    @events ||= @build.events
  end


  private
  def attribute_pairs
    {
      "status"             => @build.master_event.event_status,
      "user"               => @build.model.user_name,
      "model"              => ->(b) { link_span(b.model_id, model_path(b.model)) },
      "subject"            => ->(b) { link_span(b.model.subject_id, subject_path(b.model.subject_id)) },
      "files"              => ->(b) { link_span('data', data_dir(b)) + link_span('errors', log_dir(b,'err')) + link_span('output', log_dir(b,'out')) },
      "software"           => 'stuff',
      "processing_profile" => ->(b) { link_span(b.model.processing_profile.name, processing_profile_path(b.model.processing_profile))},
      "workflow"           => 'something else',
      "LSF job id"         => 'stuff'
    }
  end

  def model_object
    @build
  end
end
