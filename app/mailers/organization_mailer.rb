class OrganizationMailer < Paperboard::Mailer
  def template_path
    'organizations/mailer'
  end

  def invite_to_team(invite, team, sender, recipient_email)
    @team = team
    @sender = sender
    @url = join_team_organizations_url invite.key

    mail(
      to: recipient_email,
      from: "\"#{@sender.full_name}\" <notifications@paperboard.me>",
      subject: "I invited you to join the team #{@team.name}",
      template_path: template_path
    )
  end
end