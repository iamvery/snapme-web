class InvitationMailer < ActionMailer::Base
  default from: 'noreply@snapme.herokuapp.com'

  def send_invitation(request, invitation)
    @invitation_token = invitation.token
    mail subject: 'Snapme Invitation', to: request.email
  end
end
