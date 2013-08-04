require 'spec_helper'

describe InvitationRequestsController do
  describe 'POST #send_invitation' do
    let(:user){ double 'User' }

    before do
      allow(User).to receive(:find_by_auth_token).and_return(user)
    end

    context 'missing invitation request' do
      let(:request_not_found){ I18n.t('invitation_request.not_found') }

      before do
        allow(InvitationRequest).to receive(:find_by_id)
        post :send_invitation, invitation_request_id: 1
      end

      specify{ expect(response).to redirect_to(root_path)  }
      specify{ expect(flash.alert).to eq(request_not_found) }
    end

    context 'valid invitation request' do
      let(:invitation_request){ double 'InvitationRequest'        }
      let(:invitation)        { double 'Invitation'               }
      let(:mail)              { double(:mail).as_null_object      }
      let(:request_sent)      { I18n.t('invitation_request.sent') }

      before do
        allow(InvitationRequest).to receive(:find_by_id).and_return(invitation_request)
        allow(Invitation).to receive(:create!).and_return(invitation)
        allow(InvitationMailer).to receive(:send_invitation).and_return(mail)
        allow(invitation_request).to receive(:destroy!)
      end

      context 'response' do
        before do
          post :send_invitation, invitation_request_id: 1
        end

        specify{ expect(response).to redirect_to(root_path) }
        specify{ expect(flash.notice).to eq(request_sent)   }
      end

      it 'creates an invitation' do
        expect(Invitation).to receive(:create!).and_return(invitation)

        post :send_invitation, invitation_request_id: 1
      end

      it 'sends the invitation to the requestor' do
        expect(InvitationMailer).to receive(:send_invitation)
          .with(invitation_request, invitation)
          .and_return(mail)
        expect(mail).to receive(:deliver)

        post :send_invitation, invitation_request_id: 1
      end

      it 'destroys the invitation request' do
        expect(invitation_request).to receive(:destroy!)
        post :send_invitation, invitation_request_id: 1
      end
    end
  end
end
