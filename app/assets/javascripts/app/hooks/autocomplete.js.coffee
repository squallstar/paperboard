@Paperboard.hook "input[data-autocomplete]", ($el) ->

  $el.typeahead({
      minLength: 3
      highlight: true
    },
    {
      name: 'people'
      displayKey: 'full_name'
      source: (query, callback) ->
        $.get '/v1/suggestions/people', { query: query }, (data) ->
          callback data.people
      templates:
        empty: "<li class='empty'>No suggestions</li>"
        header: "<ul class='people-suggestions'>"
        footer: "</ul>"
        suggestion: "<li>{{full_name}}</li>"
    }
  )