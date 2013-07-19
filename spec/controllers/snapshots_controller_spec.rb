require 'spec_helper'

describe SnapshotsController do
  describe 'POST #create' do
    let(:user)    { double 'User'  }
    let(:snapshot){ 'snapshot.jpg' }

    before do
      allow(User).to receive(:find).and_return(user)
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