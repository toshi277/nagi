class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: "レビューを削除しました"
  end
end

