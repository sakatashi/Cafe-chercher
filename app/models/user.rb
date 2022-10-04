class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts,    dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  
   # アイコン画像設定
  has_one_attached :image
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize_to_fill: [width, height]).processed
  end
  
  # ゲストログイン機能
   def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
   end
end

