class User < ActiveRecord::Base
  mount_uploader :snapshot, SnapshotUploader
end
