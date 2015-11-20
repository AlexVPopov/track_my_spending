#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require bootstrap-sprockets
#= require select2
#= require bootstrap-datepicker
#= require datatables
#= require modernizr
#= require moment
#= require turbolinks
#= require expenses


if window.location.hash and window.location.hash == '#_=_'
  if window.history and history.pushState
    window.history.pushState '', document.title, window.location.pathname
  else
    # Prevent scrolling by storing the page's current scroll offset
    scroll =
      top: document.body.scrollTop
      left: document.body.scrollLeft
    window.location.hash = ''
    # Restore the scroll offset, should be flicker free
    document.body.scrollTop = scroll.top
    document.body.scrollLeft = scroll.left
