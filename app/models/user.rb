class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts,    dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy
  
   def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
    end
   end
end

