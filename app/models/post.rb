class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true, length: {minimum: 2, maximum: 255}
  validates :body, presence: true, length: {minimum: 2, maximum: 2550}

  validate :images_validate

  def images_validate
    if images.attached?
      images.each do |image|
        type = image.content_type.split('/').last
       if !(type == 'jpg' || type == 'jpeg' || type == 'png')
         errors.add(:images, "The file #{image.filename} must be image file")
       end
      end
    end
  end
end
