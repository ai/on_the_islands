jQuery ($) ->

  $('[rel=submit]').click ->
    $(this).closest('form').submit()
    false
