module ApplicationHelper
  def tab_hash
    ['model', 'processing_profile', 'sample', 'instrument_data'].each_with_object({}) do |item, h|
      h["#{item}_active".to_sym] = if params[:controller] == item
                              'active'
                            else
                              nil
                            end
    end
  end

  def link_span(text, path, icon_class = nil)
    if icon_class
      link_to(
        content_tag(:span,
                    content_tag(:i, '', class: icon_class) +  " #{text}",
                    class: "label label-inverse"
                   ),
        path)
    else
      link_to(
        content_tag(:span, text, class: "label label-inverse"),
        path
      )
    end
  end

  def render_value_for_model_or_build_input(input)

    case input.value_class_name
    when /^Genome::Model::Build/
      path_finder = 'build_path'
      type_label = "build"
    when /^Genome::InstrumentData/
      path_finder = 'instrument_data_path'
      type_label = "instrument data"
    when /^Genome::Sample/
      path_finder = 'sample_path'
      type_label = "sample"
    when /^Genome::Project/
      path_finder = 'project_path'
      type_label = "project"
    when /^Genome::ModelGroup/
      path_finder = 'model_group_path'
      type_label = "model group"
    when /^Genome::FeatureList/
      #path_finder = 'feature_list_path'
    when /^Genome::File::Fasta/
      path_url = "http://gscweb.gsc.wustl.edu/#{input.value_id}"
      extra_classes = "icon-file icon-white"
      type_label = "FASTA file"
    when /^Genome::Model/  # Keep this one at the end, since other classes start with Genome::Model, too
      path_finder = 'model_path'
      type_label = "model"
    else
      case input.name
      when /directory/
        path_url = "http://gscweb.gsc.wustl.edu/#{input.value_id}"
        extra_classes = "icon-folder-open icon-white"
      when /file/
        path_url = "http://gscweb.gsc.wustl.edu/#{input.value_id}"
        extra_classes = "icon-file icon-white"
      end
    end

    if path_finder
      link_span(type_label + ' ' + input.value_id, send(path_finder, input.value_id), extra_classes);
    elsif path_url
      link_span(input.value_id, path_url, extra_classes)
    else
      input.value_id
    end
  end

end
