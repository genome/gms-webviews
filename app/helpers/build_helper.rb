module BuildHelper
    # returns a string containing a span tag to represent the success/fail
    # status of a build
    def status_label_for_build(build)
        classes = ['label']
        if (build.master_event)
            status = build.master_event.event_status
            case status
            when 'Succeeded'
                classes.push('label-success')
            when 'Failed'
                classes.push('label-important')
            when 'Running'
                classes.push('label-info');
            end
        else
            status = 'No events'
        end
        content_tag(:span, status, :class => classes)
    end
end
