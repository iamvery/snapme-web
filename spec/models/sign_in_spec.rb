require 'spec_helper'

describe SignIn do
  let(:auth_hash)       { double :auth_hash        }
  let(:invitation_token){ double :invitation_token }
  let(:invitation)      { double 'Invitation'      }
  let(:user)            { double 'User'            }

  subject(:sign_in){ described_class.new(auth_hash, invitation_token) }

  describe '#user' do
    context 'user exists' do
      it 'finds the User by its auth hash' do
        expect(User).to receive(:find_by_auth_hash).with(auth_hash).and_return(user)

        sign_in.user
      end

      it 'returns found User' do
        allow(User).to receive(:find_by_auth_hash).and_return(user)

        expect(sign_in.user).to eq(user)
      end
    end

    context 'with valid invitation token' do
      before do
        allow(User).to receive(:find_by_auth_hash).and_return(nil)
        allow(User).to receive(:create_by_auth_hash).and_return(user)
        allow(Invitation).to receive(:find_by_token).and_return(invitation)
        allow(invitation).to receive(:destroy!)
      end

      it 'creates the User by its auth hash' do
        expect(User).to receive(:create_by_auth_hash).with(auth_hash)

        sign_in.user
      end

      it 'invitation is destroyed' do
        expect(invitation).to receive(:destroy!)

        sign_in.user
      end

      it 'returns created User' do
        expect(sign_in.user).to eq(user)
      end
    end

    context 'with invalid invitation token' do
      before do
        allow(User).to receive(:find_by_auth_hash).and_return(nil)
        allow(Invitation).to receive(:find_by_token)
      end

      it 'neither finds nor creates a User' do
        expect(sign_in.user).to be_nil
      end
    end
  end
end
