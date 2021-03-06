class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :posts
  has_many :comments
  belongs_to :role
  has_one_attached :avatar

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :email, presence: true, length: {minimum: 6, maximum: 255}, uniqueness: true,
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password

  validate :rule_avatar_validated

  def rule_avatar_validated
    if avatar.attached?
      type = avatar.content_type.split('/').last
      if !(type == 'jpg' || type == 'jpeg' || type == 'png')
        errors.add(:avatar, "The only support formats are jpg, jpeg and png...")
      end
    end
  end

  def admin?
    role.code == 'ADMIN'
  end

  def normal_user?
    role.code == 'USER'
  end
end
