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
end
