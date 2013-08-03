require 'base64'

class SnapshotsController < AuthenticatedController
  protect_from_forgery except: :create

  def create
    current_user.snapshot = snapshot
    current_user.save!
    current_user.notify_new_snapshot
    head :ok
  ensure
    snapshot.close
    snapshot.unlink if snapshot.is_a?(Tempfile)
  end

  private

  def snapshot_param
    params[:snapshot]
  end

  def snapshot
    @snapshot ||= if snapshot_param.is_a?(String)
      encoded_image_data = snapshot_param.split(',').last
      image_data         = Base64.decode64(encoded_image_data)

      file = Tempfile.open('data-uri-file') do |f|
        f.binmode
        f.write(image_data)
        f
      end
    else
      snapshot_param
    end
  end
end
