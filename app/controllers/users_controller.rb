class UsersController < AuthenticatedController
  def index
    @users = User.all
  end
end
