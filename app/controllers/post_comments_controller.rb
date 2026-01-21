class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.new(comment_params)
      @comment.post = @post
  
      if @comment.save
        redirect_to post_path(@post), notice: "コメントを追加しました。"
      else

        @comments = @post.comments.includes(:user).order(created_at: :desc)
        flash.now[:alert] = "コメントを入力してください。"
        render "posts/show", status: :unprocessable_entity
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
  
      if @comment.user == current_user
        @comment.destroy
        redirect_to post_path(@post), notice: "コメントを削除しました。"
      else
        redirect_to post_path(@post), alert: "削除権限がありません。"
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  
  