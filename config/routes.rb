Rails.application.routes.draw do

  get 'search', to: 'searches#search'

  root to: 'homes#top'
  get 'about', to: 'homes#about'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  get 'mypage', to: 'users#show'
  resource :user, only: [:edit, :update, :destroy]


  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


  resources :users, only: [:index, :show]


  devise_for :admins,
    skip: [:registrations, :passwords],
    controllers: { sessions: 'admin/sessions' }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show] do
      member do
        patch :withdraw
      end
    end
    resources :posts, only: [:index, :destroy]
  end

end




  


  






