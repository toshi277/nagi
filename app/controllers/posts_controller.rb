class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:mine, :create, :new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def index
    @post  = Post.new
    @posts = Post.includes(:user, :tags).order(created_at: :desc)
  end

  def mine
    @user  = current_user
    @post  = Post.new
    @posts = current_user.posts.includes(:tags).order(created_at: :desc)
  end

  def show
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      save_tags(@post)
      redirect_to post_path(@post), notice: "Post was successfully created."
    else
      @posts = Post.includes(:user, :tags).order(created_at: :desc)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      save_tags(@post)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_path, notice: "Post was successfully deleted."
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :rate)
  end

  def save_tags(post)
    tag_list = params.dig(:post, :tag_names).to_s.split(",").map(&:strip).reject(&:blank?)
    post.tags = tag_list.map { |name| Tag.find_or_create_by(name: name) }
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end
end


