class BuildPresenter < SimpleDelegator
  include Mixins::PresenterWithAttributes

  def initialize(build)
    @build = build
    super(build)
  end

  def model
    @model ||= @build.model
  end

  def model_name
    model.name
  end

  def workflow_instance
    Maybe(@build.workflow_instance)
  end

  def display_label
    "#{@build.id} of #{@build.model.name}"
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
      "user"               => @build.user_name,
      "model"              => ->(b) { link_span(b.model_id, model_path(b.model)) },
      "subject"            => ->(b) { link_span(b.model.subject_id, sample_path(b.model.subject_id)) },
      "files"              => ->(b) { link_span('data', data_dir(b)) + link_span('errors', log_dir(b,'err')) + link_span('output', log_dir(b,'out')) },
      "software"           => 'stuff',
      "processing_profile" => ->(b) { link_span(b.model.processing_profile.name, processing_profile_path(b.model.processing_profile))},
      "workflow"           => "#{Maybe(@build.workflow_instance).name} (#{Maybe(@build.workflow_instance).id})",
      "LSF job id"         => 'stuff'
    }
  end

  def model_object
    @build
  end
end
