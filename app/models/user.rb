class User < ActiveRecord::Base
  PUSHER_CHANNEL            = 'user_channel'
  PUSHER_NEW_SNAPSHOT_EVENT = 'new_snapshot'

  before_save :ensure_auth_token

  mount_uploader :snapshot, SnapshotUploader

  def notify_new_snapshot
    Pusher[User::PUSHER_CHANNEL].trigger(
      User::PUSHER_NEW_SNAPSHOT_EVENT,
      user_id:      id,
      snapshot_url: snapshot.url )
  end

  def self.find_or_create_by_auth_hash(auth_hash)
    provider = auth_hash.provider
    uid      = auth_hash.uid
    username = auth_hash.info.nickname

    find_or_create_by(provider: provider, uid: uid, username: username)
  end

  private

  def ensure_auth_token
    self.auth_token = SecureRandom.hex unless auth_token
  end
end
