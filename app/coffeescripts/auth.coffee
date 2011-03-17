app.content 'header .auth', ($, $$, auth) ->
  
  url = $$('[type=url]')
  submit = $$('form a')
  form = $$('form')
  
  $$('[rel=openid]').click =>
    form.find('.elements').width(url.outerWidth(true) + submit.width())
    form.animate({ width: auth.width() }, 150)
    url.val('http://').focus()
    $('html').one 'click', (e) ->
      if e.target isnt submit[0] and e.target isnt url[0]
        form.animate({ width: 0 }, 150)
    false
  
  $('header')
    .bind 'flash.show', ->
      auth.fadeOut(app.flash.duration / 2)
    .bind 'flash.hide', ->
      auth.fadeIn(app.flash.duration)
