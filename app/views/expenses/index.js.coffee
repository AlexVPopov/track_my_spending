initializeDateTable = (element) ->
  element.DataTable
    columnDefs: [
      orderable: false,
      targets: [1, 3]
    ]
    order: [[0, 'desc']]
    paging: false
    dom: 't'

initializeSearch = (table) ->
  $('#search').on 'keyup', ->
    table.search(this.value).draw()

$('.dt-bootstrap').remove()
$('.filter').after $("<%= j render 'table', expenses: @expenses, model_class: Expense %>")
table = initializeDateTable($('.datatable'))
initializeSearch(table)
