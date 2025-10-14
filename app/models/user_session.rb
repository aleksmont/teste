class UserSession < ApplicationRecord
  belongs_to :user

  before_create :set_logged_at

  private

  def set_logged_at
    self.logged_at = Time.now
  end
end
