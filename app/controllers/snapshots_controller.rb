class SnapshotsController < AuthenticatedController
  protect_from_forgery except: :create

  def create
    user.snapshot = snapshot
    user.save!
    user.notify_new_snapshot
    head :ok
  end

  private

  def snapshot
    params[:snapshot]
  end

  def user
    @user ||= User.find(user_id)
  end

  def user_id
    params[:user_id]
  end
end
