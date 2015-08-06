$ ->
  $('.datatable').DataTable()

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
    tokenSeparators: [',']
