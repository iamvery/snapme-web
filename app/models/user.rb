class User < ActiveRecord::Base
  mount_uploader :snapshot, SnapshotUploader

  def self.find_or_create_by_auth_hash(auth_hash)
    provider = auth_hash.provider
    uid      = auth_hash.uid
    username = auth_hash.info.nickname

    find_or_create_by_provider_and_uid_and_username(provider, uid, username)
  end
end
