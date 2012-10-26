$ ->
  $('#workflow_table').on(
    click: ->
      breadcrumbs = $('ul.breadcrumb li')
      if $(this).hasClass('workflow_breadcrumb_link')
          index = $(this).index(breadcrumbs)
          document.save_breadcrumbs = breadcrumbs.slice( 1, index+1 )
      else
        document.save_breadcrumbs = breadcrumbs
      $('#workflow_content').hide()
      $('#workflow_spinner').show()
      $.ajax( $(this).attr('href') )
        .done( (data) ->
          $("#workflow_table").html(data)
          $('#workflow_content').show()
          $('#workflow_spinner').hide()
          $('ul.breadcrumb li:first').prepend(document.save_breadcrumbs)
        )
        .fail( ->
          alert("unable to load workflow data!")
          $('#workflow_content').show()
          $('#workflow_spinner').hide()
        )
      return false
  , 'a.workflow_link')
