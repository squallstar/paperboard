module Paperboard
  class Mailer < ActionMailer::Base
    default from: "\"Paperboard\" <no-reply@paperboard.me>"
    layout 'emails'
  end
end