jQuery ($) ->

  flash = $('header .flash')
  app.flash.autohide(flash) if flash.length

  home = $('header .home, header .logo')
  home.hover(
    -> home.addClass('hover'),
    -> home.removeClass('hover'))
