@Paperboard.hook "div[data-source]", ($el) ->

  console.log 'running hook'

  $el.each ->
    timeout = undefined

    $container = $ @
    $input = $el.find 'input'
    $suggestions = $ '<ul></ul>'

    $container.append $suggestions

    parseContent = (data) ->
      $container.toggleClass 'with-suggestions', data.length
      $suggestions.html data

    $input.on "keyup", ->
      clearInterval(timeout) if timeout
      query = $input.val()

      return parseContent('') unless query

      timeout = window.setTimeout (=>
        $container.addClass 'is-loading'
        $.get $container.data('source'), { query: query }, (data) ->
          $container.removeClass 'is-loading'
          parseContent data
      ), 250