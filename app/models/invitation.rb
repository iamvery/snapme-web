class Invitation < ActiveRecord::Base
  before_save :ensure_token

  private

  def ensure_token
    self.token ||= SecureRandom.hex
  end
end
