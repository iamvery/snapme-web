class InvitationRequestsController < ApplicationController
  respond_to :html

  before_filter :authenticate, only: :index

  def index
    @invitation_requests = InvitationRequest.all
  end

  def new
    @invitation_request = InvitationRequest.new
  end

  def create
    @invitation_request = InvitationRequest.new(invitation_request_params)

    if @invitation_request.save
      redirect_to root_path, notice: t('invitation_request.create.success')
    else
      render :new
    end
  end

  def destroy
    invitation_request = InvitationRequest.find(params[:id])
    invitation_request.destroy!
    respond_with invitation_request
  end

  def send_invitation
    invitation_request = InvitationRequest.find(params[:invitation_request_id])

    if invitation_request
      invitation = Invitation.create!
      InvitationMailer.send_invitation(invitation_request, invitation).deliver
      invitation_request.destroy!
      redirect_to root_path, notice: t('invitation_request.sent')
    else
      redirect_to root_path, alert: t('invitation_request.not_found')
    end
  end

  private

  def invitation_request_params
    params.require(:invitation_request).permit(:email)
  end
end
