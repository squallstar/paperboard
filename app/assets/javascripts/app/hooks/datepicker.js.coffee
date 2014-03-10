@Paperboard.hook "input.datepicker", ($el) ->
  $el.pickadate
    format: 'yyyy-mm-dd'
    formatSubmit: 'yyyy-mm-dd'