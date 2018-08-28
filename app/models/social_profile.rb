class SocialProfile < ApplicationRecord
  belongs_to :user

  def assign_auth_hash(hash)
    self.uid = hash[:uid]
    self.provider = hash[:provider]
    self.email = hash[:info][:email]
    self.name = hash[:info][:name]
  end

end
