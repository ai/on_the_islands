app.flash =

  error: (text) ->
    app.flash._show('error', text)
  
  notice: (text) ->
    app.flash._show('notice', text)

  autohide: (flash) ->
    flash.data('timeout', setTimeout(app.flash.hide, 5000))
    flash.hover(
      -> $(this).data('hover', true),
      -> $(this).data('hover', null))
    flash.click (e) ->
      app.flash.hide() unless $(e.target).is('a')

  hide: (callback) ->
    flash = $('header .flash')
    clearTimeout(flash.data('timeout'))
    if flash.data('hover')
      flash.mouseout(app.flash.hide)
    else
      $('header').removeClass('notice error alert').trigger('flash.hide')
      flash.animate { marginTop: -flash.height() }, app.flash.duration, ->
        flash.remove()
        callback?()

  duration: 300
  
  _show: (cls, text) ->
    if $('header .flash').length
      app.flash.hide(-> app.flash._create(cls, text) )
    else
      app.flash._create(cls, text)
  
  _create: (cls, text) ->
    flash = $('<div />').addClass("flash #{cls}").
      append($('<div />').addClass('center').html(text)).
      prependTo('header .row')
    $('header').addClass(cls).trigger('flash.show')
    flash.addClass('small') if text.length > 115
    flash.css('margin-top', -flash.height()).
      animate({ marginTop: 0 }, app.flash.duration)
    app.flash.autohide(flash)
