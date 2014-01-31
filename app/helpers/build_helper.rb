module BuildHelper
  # returns a string containing a span tag to represent the success/fail
  # status of a build
  def status_label_for_build(build)
    classes = []
    if (build.master_event)
      status = build.master_event.event_status
      classes.push  label_class_for_status(status)
    else
      status = 'No events'
    end
    content_tag(:span, status, :class => classes)
  end

  def status_label_for_workflow_operation(op)
    classes = []
    status = op.status.capitalize
    classes.push label_class_for_status(status)
    content_tag(:span, status, :class => classes)
  end

  def label_class_for_status(status)
    classes = ['label']
    case status
    when 'Succeeded'
      classes.push('label-success')
    when 'Done'
      classes.push('label-success')
    when 'Failed'
      classes.push('label-important')
    when 'Running'
      classes.push('label-info');
    when 'Crashed'
      classes.push('label-important');

    end
  end


  def render_build_inputs(build_input_data)
    input_list_contents = build_input_data['only_on_model'].values.inject([]) {
      |contents, build_input|
      contents.push(content_tag(:dt, build_input.name))
      contents.push(content_tag(:dd, 'missing on build'))
    }

    input_list_contents = build_input_data['only_on_build'].values.inject(input_list_contents) {
      |contents, build_input|
      contents.push(content_tag(:dt, build_input.name))
      contents.push(render_value_for_model_or_build_input(build_input) + ' (missing on model)')
    }

    input_list_contents = build_input_data['different'].values.inject(input_list_contents) {
      |contents, build_input|
      contents.push(content_tag(:dt, build_input.name))
      contents.push(render_value_for_model_or_build_input(build_input))
    }

    content_tag(:dl, raw(input_list_contents.join));
  end

  def log_dir(build, format)
    "#{data_dir(build)}/logs/#{build.master_event.id}.#{format}"
  end

  def data_dir(build)
    "/#{build.data_directory}"
  end
end
