class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :post_comments, dependent: :destroy

 
  def active_for_authentication?
    super && !is_deleted
  end

  def inactive_message
    is_deleted ? :deleted_account : super
  end

  GUEST_EMAIL = "guest@example.com".freeze

  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64(16)
      user.name = "ゲスト"
      user.introduction = "ゲストログイン中です"
      user.is_deleted = false if user.respond_to?(:is_deleted)
    end
  end
end





