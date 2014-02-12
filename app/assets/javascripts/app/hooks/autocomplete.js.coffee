@Paperboard.hook "div[data-source]", ($el) ->

  $el.each ->
    timeout = undefined

    $container = $ @
    $input = $el.find 'input'
    $suggestions = $ '<ul></ul>'

    $container.append $suggestions

    parseContent = (data = '') ->
      $container.toggleClass 'with-suggestions', data.length
      $suggestions.html data

    postContent = (name, value) ->
      $('<form action="' + $input.data('post') + '" method="POST">' +
        '<input type="hidden" name="' + name + '" value="' + value + '">' +
        '</form>').submit()

    $suggestions.on "click", "a", (event) ->
      do event.preventDefault
      $el = $ @
      postContent $el.data('name'), $el.data('value')

    $input.on "keyup", (event) ->
      clearInterval(timeout) if timeout
      query = $input.val()

      if event.keyCode is 13
        value = $input.val()
        if $input.data('accept') is 'email'
          return $input.select() unless Paperboard.helpers.Regexps.isValidEmail value

        do parseContent
        return postContent 'email', value

        url = $input.data 'post'
        return

      return do parseContent unless query

      timeout = window.setTimeout (=>
        $container.addClass 'is-loading'
        $.get $container.data('source'), { query: query }, (data) ->
          $container.removeClass 'is-loading'
          parseContent data
      ), 250