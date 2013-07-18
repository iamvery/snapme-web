class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  def failure
    redirect_to new_session_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
