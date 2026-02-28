class Users::SessionsController < Devise::SessionsController
    def guest_sign_in
      user = User.guest
      sign_in(:user, user)
      redirect_to posts_path, notice: "ゲストユーザーとしてログインしました。"
    end
  end