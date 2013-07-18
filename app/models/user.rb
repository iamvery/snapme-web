class User < ActiveRecord::Base
  mount_uploader :snapshot, SnapshotUploader

  def self.find_or_create_by_auth_hash(auth_hash)
    provider = auth_hash.provider
    uid      = auth_hash.uid
    username = auth_hash.info.nickname

    find_or_create_by(provider: provider, uid: uid, username: username)
  end
end
