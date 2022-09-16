Rails.application.routes.draw do

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :admin do
    resources :users do
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :posts

    get 'search' => 'posts#search'
    get 'relationships/followings'
    get 'relationships/followers'
  end

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end

  scope module: :public do

    root to: 'homes#top'

    resources :users do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'

      get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'

      member do   #member doを使うと、ユーザーidが含まれてるurlを使えるようになる（users/:id/favorites）
        get :favorites
      end

    end

    resources :posts do
      resource :favorites, only: [:create, :destroy]  #いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、resourceを使う。URLに/:idを含めない形
      resources :post_comments, only: [:create, :destroy]
      get 'search' => 'posts#search'
    end

  end

end
