class Post < ApplicationRecord
  belongs_to :user
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

   enum is_draft: { published: 0, draft: 1 }
  has_one_attached :image
end
