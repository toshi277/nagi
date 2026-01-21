class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:mine, :create, :new, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def mine
    @user  = current_user
    @post  = Post.new
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user)
  end
  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_path(current_user), notice: "Post was successfully created."
    else
      
      @user  = current_user
      @posts = @user.posts.order(created_at: :desc)
      render "users/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user), notice: "Post was successfully deleted."
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end
end

