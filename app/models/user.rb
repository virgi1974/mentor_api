class User < ActiveRecord::Base
  has_many :conversations
  has_many :comments

  has_secure_password

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true
  validates :api_token, uniqueness: true

  validates :password_digest, presence: true
  validates :password_digest, uniqueness: true

  before_create -> { self.api_token = SecureRandom.hex }

  
end
