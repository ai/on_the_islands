app.content 'header .auth', ($, $$, auth) ->
  
  url = $$('[type=url]')
  submit = $$('form a')
  form = $$('form')
  
  $$('[rel=openid]').click =>
    form.find('.elements').width(url.outerWidth(true) + submit.width())
    form.animate({ width: auth.width() }, 150)
    url.val('http://').focus()
    $('html').one 'click', (e) ->
      form.animate({ width: 0 }, 150) if e.target isnt submit
    false
