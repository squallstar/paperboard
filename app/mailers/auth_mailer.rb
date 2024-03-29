class AuthMailer < Paperboard::Mailer
  def confirm_email(user)
    @user = user
    @url = signup_confirm_email_url user.id, user.optin_key
    mail(to: user.email, subject: 'Please confirm your email')
    logger.info "AuthMailer: Confirmation email sent to user ##{user.id} #{user.email}"
  end

  def welcome(user)
    @user = user
  	 mail(to: user.email, subject: 'Welcome to Paperboard')
  end

  def reset_password(user)
    @user = user
    @url = reset_password_url user.id, user.generate_request_token

    mail(to: user.email, subject: 'Please reset your Paperboard Password')
    logger.info "AuthMailer: Reset password email sent to user ##{user.id} #{user.email}"
  end
end
