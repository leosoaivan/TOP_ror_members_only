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

  def new_token
    SecureRandom.urlsafe_base64
  end

  def new_digest
    Digest::SHA1.hexdigest(new_token)
  end
  
  def remember
    self.remember_token = new_digest
  end
  
end
