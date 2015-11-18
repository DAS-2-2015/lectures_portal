class User < ActiveRecord::Base
  has_many :enrollments
  has_many :lectures, through: :enrollments
  has_many :notifications
  has_many :followers
  has_many :users, through: :followers, source: :panelist
  has_many :reviews

  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
