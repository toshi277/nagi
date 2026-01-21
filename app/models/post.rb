class Post < ApplicationRecord
    belongs_to :user  
    
    validates :title, presence: true
    validates :body, presence: true
  
    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :post_comments, dependent: :destroy
  
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end
  end
  
  
  
  