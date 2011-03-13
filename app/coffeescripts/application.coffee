window.app =
  
  log: ->
    console?.log?.apply(console, arguments)
  
  content: (selector, callback) ->
    jQuery ($) ->
      html = $(selector)
      if html.length
        search = (query) ->
          $(query, html)
        callback($, search, html)

window.log = app.log
