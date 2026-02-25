class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post = @post

    if @post_comment.save
      redirect_to post_path(@post), notice: "コメントを追加しました。"
    else
      @post_comments = @post.post_comments.includes(:user).order(created_at: :desc)
      flash.now[:alert] = "コメントを入力してください。"
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])

    if @post_comment.user == current_user
      @post_comment.destroy
      redirect_to post_path(@post), notice: "コメントを削除しました。"
    else
      redirect_to post_path(@post), alert: "削除権限がありません。"
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

  
  