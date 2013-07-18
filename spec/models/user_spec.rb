require 'spec_helper'
require 'ostruct'

describe User do
  let(:auth_hash) do
    OpenStruct.new(
      provider: provider,
      uid:      uid,
      info:     OpenStruct.new(nickname: username) )
  end

  let(:provider){ double :provider }
  let(:uid)     { double :uid      }
  let(:username){ double :username }

  describe '.find_or_create_by_auth_hash' do
    it 'delegates to ActiveRecord method with appropriate information' do
      expect(User).to receive(:find_or_create_by)
        .with(provider: provider, uid: uid, username: username)

      described_class.find_or_create_by_auth_hash(auth_hash)
    end
  end
end
