class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum: 2, maximum: 255}
  validates :body, presence: true, length: {minimum: 2, maximum: 2550}
end
