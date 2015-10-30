initializeDatepicker = (element) ->
  element.datepicker
    autoclose: true
    format: 'yyyy-mm-dd'
    orientation: 'top auto'
    todayBtn: true
    todayHighlight: true
  .on 'changeDate', ->
    $('form').submit()


$ ->
  table = $('.datatable').DataTable
    columnDefs: [
      orderable: false,
      targets: [1, 3]
    ]
    dom: 't'

  $('#search').on 'keyup', ->
    table.search(this.value).draw()


  $('#expense_tag_list').select2
    ajax:
      url: '/tags'
      data:
        (query) ->
          query: query.term
      processResults:
        (data) ->
          results: data
      cache: true
    placeholder: 'Enter tag(s)'
    tags: true
    theme: 'bootstrap'
    tokenSeparators: [',']

  initializeDatepicker($('.input-group.date'))
