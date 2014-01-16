class ProjectMailer < ActionMailer::Base
  default from: "no-reply@paperboard.me"

  def send_invite(invite)
    @project = invite.project
    @url  = project_url @project
    mail(to: invite.email, subject: "You have been invited to #{@project.name}")
  end
end
