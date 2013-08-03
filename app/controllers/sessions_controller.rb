class SessionsController < ApplicationController
  before_filter :authenticate, only: :destroy

  def new
    flash[:invitation_token] = invitation_token
  end

  def create
    sign_in = SignIn.new(auth_hash, invitation_token)

    if sign_in.user
      session[:user_id] = sign_in.user_id
      flash[:notice] = t('sign_in.success')
    else
      flash[:alert] = t('sign_in.failure')
    end

    redirect_to root_path
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
