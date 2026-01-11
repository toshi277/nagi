Rails.application.routes.draw do
  root to: "homes#top"
  get "about", to: "homes#about"

  devise_for :users

  get "mypage", to: "users#show"

  resource :user, only: [:edit, :update, :destroy]   

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
end






