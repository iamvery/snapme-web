class SignIn
  attr_reader :auth_hash, :invitation_token

  delegate :id, to: :user, prefix: true, allow_nil: true

  def initialize(auth_hash, invitation_token)
    @auth_hash        = auth_hash
    @invitation_token = invitation_token
  end

  def user
    return found_or_created_user if found_or_created_user
    user = find_user

    if !user && invitation
      user = create_user
      invitation.destroy!
    end

    user
  end

  private

  def found_or_created_user
    @user
  end

  def find_user
    @user ||= User.find_by_auth_hash(auth_hash)
  end

  def create_user
    @user ||= User.create_by_auth_hash(auth_hash)
  end

  def invitation
    @invitation ||= Invitation.find_by_token(invitation_token)
  end
end
