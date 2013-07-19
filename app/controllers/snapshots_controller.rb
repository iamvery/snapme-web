class SnapshotsController < AuthenticatedController
  protect_from_forgery except: :create

  def create
    current_user.snapshot = snapshot
    current_user.save!
    current_user.notify_new_snapshot
    head :ok
  end

  private

  def snapshot
    params[:snapshot]
  end
end
