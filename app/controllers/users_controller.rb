class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @post  = Post.new
    @posts = current_user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    user = current_user
    user.destroy
    redirect_to root_path, notice: "退会しました"
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end
end





