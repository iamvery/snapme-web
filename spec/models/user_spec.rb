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

  describe '#notify_new_snapshot' do
    let(:id)          { 1               }
    let(:pusher)      { double 'Pusher' }
    let(:snapshot_url){ double :url     }

    subject(:user){ described_class.new(id: id) }

    before do
      allow_any_instance_of(SnapshotUploader).to receive(:url)
        .and_return(snapshot_url)
    end

    it 'triggers new snapshot event on user channel' do
      expect(Pusher).to receive(:[])
        .with(described_class::PUSHER_CHANNEL)
        .and_return(pusher)

      expect(pusher).to receive(:trigger)
        .with(described_class::PUSHER_NEW_SNAPSHOT_EVENT, user_id: id, snapshot_url: snapshot_url)

      user.notify_new_snapshot
    end
  end

  describe '.find_or_create_by_auth_hash' do
    it 'delegates to ActiveRecord method with appropriate information' do
      expect(User).to receive(:find_or_create_by)
        .with(provider: provider, uid: uid, username: username)

      described_class.find_or_create_by_auth_hash(auth_hash)
    end
  end

  describe '.find_by_auth_hash' do
    it 'delegates to ActiveRecord method with appropriate information' do
      expect(User).to receive(:find_by)
        .with(provider: provider, uid: uid, username: username)

      described_class.find_by_auth_hash(auth_hash)
    end
  end

  describe '.create_by_auth_hash' do
    it 'delegates to ActiveRecord method with appropriate information' do
      expect(User).to receive(:create!)
        .with(provider: provider, uid: uid, username: username)

      described_class.create_by_auth_hash(auth_hash)
    end
  end
end
