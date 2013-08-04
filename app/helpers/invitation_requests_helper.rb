module InvitationRequestsHelper
  def send_invitation_link(request)
    link_to(
      'Send Invitation',
      invitation_request_send_path(request),
      method: :post,
      rel:    'send-invitation',
      class:  %i(btn btn-inverse),
    )
  end

  def delete_invitation_request_link(request)
    link_to(
      'Delete Request',
      invitation_request_path(request),
      method: :delete,
      data:   {confirm: 'Sure?'},
      class:  %i(btn btn-danger),
    )
  end
end
