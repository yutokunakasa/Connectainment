Rails.application.routes.draw do
  devise_for :users
  resources :users do
    get "users_movie_favorites" => "favorites#users_movie_favorites"
    get "users_movie_index" => "movies#users_movie_index"
    get "following_user_movies" => "movies#following_user_movies"
    get "user_tweets" => "tweets#user_tweets"
    get "admin/users" => "admin/users#index"
    get "admin/tweets" => "admin/tweets#index"
    member do
      get :following, :followers
    end
  end
  resources :relationships, only:[:create, :destroy]

  resources :movies do
  	resources :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end

  resources :tweets do
    resources :replies, only: [:create, :destroy]
  end
  namespace :admin do
    resources :users
    resources :tweets
  end

  resources :admin_informations

  get "top" => "homes#top"
  get "about" => "homes#about"
  root "homes#top"

end
