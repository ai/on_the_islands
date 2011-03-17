( ($) ->

  $.fn.css3 = (name, value) ->
    prefix = if $.browser.webkit
      '-webkit-'
    else if $.browser.opera
      '-o-'
    else if $.browser.mozilla
      '-moz-'
    else if $.browser.msie
      '-ms-'
    
    if prefix
      if value
        this.css(prefix + name, value)
        this.css(name, value)
      else
        this.css(name) || this.css(prefix + name)
    else
      this.css.apply(this, arguments)

)(jQuery)
