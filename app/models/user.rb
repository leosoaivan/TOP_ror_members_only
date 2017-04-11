require 'digest'

class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :posts

  before_create :remember
  before_save { email.downcase! }
  
  validates :name,  presence: true, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.new_digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def remember
    self.remember_digest = User.new_digest(User.new_token)
  end
  
end
