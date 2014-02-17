@Paperboard.hook "#choose_context", ($el) ->

  $button = $el.find 'button'
  $contexts = $el.find 'ul li a'

  $button.click (event) ->
    do event.preventDefault
    $el.toggleClass 'open'
    false

  $contexts.click (event) ->
    do event.preventDefault
    $context = $ @
    $el.removeClass 'open'
    $button.html $context.html()

  do $contexts.first().click