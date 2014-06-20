class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.where(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]).first

    if !user
      attrs = {
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        name: auth_hash['info']['name'],
        email: auth_hash['info']['email'],
        location: auth_hash['info']['location'],
        locale: auth_hash['extra']['raw_info']['locale'],
        hometown: auth_hash['extra']['raw_info']['hometown']['name']
      }
      user = User.create(attrs)
    elsif user.location != auth_hash['info']['location']
      user.update(location: auth_hash['info']['location'])

    end

    user
  end
end
