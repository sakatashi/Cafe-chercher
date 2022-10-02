class Post < ApplicationRecord
  belongs_to :user
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  has_one_attached :image
end
