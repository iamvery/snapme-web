class SessionsController < ApplicationController
  before_filter :authenticate, only: :destroy

  def new
    flash[:invitation_token] = invitation_token
  end

  def create
    user = User.find_or_create_by_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path, notice: t('sign_in.success')
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: t('sign_out.success')
  end

  def failure
    redirect_to new_session_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def invitation_token
    params[:invitation_token] || flash[:invitation_token]
  end
  helper_method :invitation_token
end
