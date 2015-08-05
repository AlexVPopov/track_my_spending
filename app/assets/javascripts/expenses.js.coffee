$ ->
  $('.datatable').DataTable()

  $('#expense_tag_list').select2
    ajax:
      url: '/tags'
      dataType: 'json'
      data: (query) ->
              'query=' + encodeURIComponent(query)
      results:
        (data, page) ->
          results: data
      cache: true
      quietMillis: 250
    createSearchChoice:
      (term) ->
        id: $.trim(term)
        text: $.trim(term)
    initSelection:
      (element, callback) ->
        data = []
        tags = element.val().split(",")
        for tag in tags
          data.push({id: $.trim(tag), text: $.trim(tag)})
        callback(data)
    placeholder: 'Enter a tag'
    tags: true
    tokenSeparators: [","]
