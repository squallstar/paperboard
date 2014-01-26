jQuery ->
  subscription.setupForm()

subscription =
  setupForm: ->
    $('#new_subscription').submit ->
      $('input[type=submit]').attr 'disabled', true
      if $('#card_number').length
        subscription.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      exp_month: $('#card_month').val()
      exp_year: $('#card_year').val()
    paymill.createToken card, subscription.handlePaymillResponse

  handlePaymillResponse: (error, result) ->
    if error
      error_text = error.apierror

      switch error_text
        when "field_invalid_card_number"
          error_text = "The credit/debit card number is not valid"
        when "field_invalid_card_cvc"
          error_text = "The credit/debit CVC number is not valid"
        when "3ds_cancelled"
          error_text = "You didn't authorize your card"

      $('#paymill_error').text error_text
      $('input[type=submit]').attr 'disabled', false
    else
      $('#subscription_paymill_card_token').val result.token
      $('#subscription_paymill_card_last').val result.last4Digits
      $('#new_subscription')[0].submit()
