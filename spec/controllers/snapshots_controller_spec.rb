require 'spec_helper'

describe SnapshotsController do
  describe 'POST #create' do
    let(:user)    { double 'User'  }
    let(:snapshot){ 'snapshot.jpg' }

    context 'unauthenticated' do
      before do
        post :create, user_id: 1, snapshot: snapshot
      end

      specify{ expect(response).to be_redirect               }
      specify{ expect(response).to redirect_to(sign_in_path) }
    end

    context 'authenticated' do
      before do
        allow(User).to receive(:find_by_auth_token).and_return(user)
      end

      it %q(updates the user's snapshot) do
        expect(user).to receive(:snapshot=).with snapshot
        expect(user).to receive(:save!)
        expect(user).to receive(:notify_new_snapshot)

        expect(response).to be_success

        post :create, user_id: 1, snapshot: snapshot
      end
    end
  end
end
