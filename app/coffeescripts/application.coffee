jQuery ($) ->
  
  auth = $('header .auth')
  if auth.length
    url = $('[type=url]', auth)
    submit = $('form a', auth)
    
    $('[rel=openid]', auth).click ->
      $('form .elements', auth).width(url.outerWidth(true) + submit.width())
      $('form', auth).animate({ width: auth.width() }, 150)
      url.val('http://').focus()
      $('html').one 'click', (e) ->
        if e.target isnt submit
          $('form', auth).animate({ width: 0 }, 150)
      false
