Rails.application.routes.draw do

  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, :posts
  end

  scope module: :public do
    resources :users

    resources :posts
    get 'posts/search' => 'posts#search'

    root to: 'homes#top'
  end
end
