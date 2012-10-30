# trigger for index datatables.  Expects a "data-source" attribute to point to a URL with a JSON datasource.

jQuery ->
  $('.gms-entity-index').each (index) ->
    $(this).dataTable
      sPaginationType: "bootstrap"
      bJQueryUI: true
      bProcessing: true
      bServerSide: true
      sAjaxSource: $(this).data('source')
      sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
      sWrapper: "dataTables_wrapper form-inline"
      oLanguage:
        sSearch: 'Filter results:'
        sLengthMenu: "_MENU_ records per page"