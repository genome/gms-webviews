module ApplicationHelper
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
        when /^Genome::InstrumentData/
            path_finder = 'instrument_data_path'
        when /^Genome::Sample/
            path_finder = 'sample_path'
        when /^Genome::Project/
            path_finder = 'project_path'
        when /^Genome::ModelGroup/
            path_finder = 'model_group_path'
        when /^Genome::FeatureList/
            #path_finder = 'feature_list_path'
        when /^Genome::File::Fasta/
            path_url = "http://gscweb.gsc.wustl.edu/#{input.value_id}"
            extra_classes = "icon-file icon-white"
        when /^Genome::Model/  # Keep this one at the end, since other classes start with Genome::Model, too
            path_finder = 'genome_model_path'
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
            link_span(input.value_id, send(path_finder, input.value_id), extra_classes);
        elsif path_url
            link_span(input.value_id, path_url, extra_classes)
        else
            input.value_id
        end
    end
end
