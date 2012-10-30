# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#processing-profiles-datatable').dataTable
    sPaginationType: "bootstrap"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#processing-profiles-datatable').data('source')
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
    sWrapper: "dataTables_wrapper form-inline"
    oLanguage:
      sSearch: 'Filter results:'
      sLengthMenu: "_MENU_ records per page"