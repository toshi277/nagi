class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :withdraw]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
  end

  def withdraw
    @user.update(is_deleted: true)
    redirect_to admin_user_path(@user), notice: "退会処理を実行しました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

