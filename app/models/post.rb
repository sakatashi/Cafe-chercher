class Post < ApplicationRecord
  belongs_to :user
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :shop_taggings, dependent: :destroy
  has_many :shop_tags, through: :shop_taggings, dependent: :destroy

  #下書き機能
  enum is_draft: { published: 0, draft: 1 }
  #平均予算
  enum shop_price: {"~999":0,"1000~1999":1,"2000~2999":2 }

  # 投稿画像設定
  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/png')
    end
      image.variant(resize_to_fill: [width, height]).processed
  end

   # いいね機能
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

# タグ機能（投稿保存前に実行する）
  after_create do
    post = Post.find_by(id: self.id)
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.tags = []
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.tags.clear
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end

  #検索機能
  def self.search(search)
    if search != nil
      Post.where('title LIKE(?) OR shop_name LIKE(?)' , "%#{search}%",  "%#{search}%")
    else
      Post.all
    end
  end
end