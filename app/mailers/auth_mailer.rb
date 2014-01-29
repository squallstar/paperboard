class AuthMailer < ActionMailer::Base
  default from: "no-reply@paperboard.me"
  layout 'emails'

  def send_optin(user)
    @user = user
    @url = signup_confirm_email_url user.id, user.optin_key
    mail(to: user.email, subject: "Please confirm your email")
    logger.info "AuthMailer: Opt-in sent to user ##{user.id} #{user.email}"
  end

  def send_welcome(user)
  	mail(to: user.email, subject: "Welcome to Paperboard")
  end
end