class FavoritesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      post = Post.find(params[:post_id])
      current_user.favorites.create(post: post)
      redirect_back(fallback_location: root_path)
    end
  
    def destroy
      post = Post.find(params[:post_id])
      favorite = current_user.favorites.find_by(post: post)
      favorite.destroy if favorite
      redirect_back(fallback_location: root_path)
    end
  end
  
