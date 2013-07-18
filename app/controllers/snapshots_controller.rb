class SnapshotsController < AuthenticatedController
  protect_from_forgery except: :create
  respond_to :json, only: :show

  def show
    respond_with({ snapshot_uri: user.snapshot.url })
  end

  def create
    user.snapshot = snapshot
    user.save!
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
