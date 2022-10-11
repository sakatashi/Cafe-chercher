class ShopTag < ApplicationRecord
  has_many :shop_taggings, dependent: :destroy
  has_many :posts, through: :shop_taggings, dependent: :destroy
end
