class AuthMailer < ActionMailer::Base
  default from: "no-reply@paperboard.me"
  layout 'emails'

  def send_optin(user)
    @url = signup_confirm_email_path user.optin_key
    mail(to: user.email, subject: "Please confirm your email")
    logger.info "AuthMailer: Opt-in sent to user ##{user.id} #{user.email}"
  end
end