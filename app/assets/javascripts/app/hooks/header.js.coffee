@Paperboard.hook "#header", ($header) ->

  $header.find('.user').click (event) ->
    do event.preventDefault
    $header.toggleClass 'with-menu'
