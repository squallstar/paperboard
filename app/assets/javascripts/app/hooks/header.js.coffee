@Paperboard.hook "#header", ($header) ->

  # Events for the user menu
  $header.find('.user').click (event) ->
    do event.preventDefault
    $header.toggleClass 'with-menu'

  # Fade out green notifications
  $alerts = $('#notification.notice')
  if $alerts.length
    window.setTimeout (=>
      $alerts.animate
        opacity: 0
      , 1500, ->
        $alerts.slideUp 500
    ), 2000