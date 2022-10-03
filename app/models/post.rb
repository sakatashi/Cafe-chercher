class Post < ApplicationRecord
  belongs_to :user
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  enum is_draft: { published: 0, draft: 1 }
  has_one_attached :image
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/png')
    end
      image.variant(resize_to_fill: [width, height]).processed
  end
end
