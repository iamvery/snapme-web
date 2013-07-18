class User < ActiveRecord::Base
  before_save :ensure_auth_token

  mount_uploader :snapshot, SnapshotUploader

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
