$ ->
  $('.datatable').DataTable
    paging: false
    columnDefs: [
      orderable: false,
      targets: [1, 3]
    ]

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
