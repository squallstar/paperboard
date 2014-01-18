class ProjectMailer < ActionMailer::Base
  default from: "no-reply@paperboard.me"
  layout 'emails'

  def send_invite(invite, from_user)
    @project = invite.project
    @from_user = from_user
    @url = accept_project_invites_url @project, invite.key
    @user = User.where(email: invite.email).first
    mail(to: invite.email, subject: "You have been invited to #{@project.name}")
  end
end