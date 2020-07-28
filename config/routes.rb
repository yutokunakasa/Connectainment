Rails.application.routes.draw do
  
  devise_for :users
  resources :users

  resources :movies
  get "users_movie_index" => "movies#users_movie_index"

  get "top" => "homes#top"
  get "about" => "homes#about"
  root "homes#top"
end
