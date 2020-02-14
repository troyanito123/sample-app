class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :posts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :email, presence: true, length: {minimum: 6, maximum: 255}, uniqueness: true,
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end
