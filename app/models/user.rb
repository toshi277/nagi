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
end






