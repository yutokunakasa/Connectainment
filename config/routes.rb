Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :movies

  get "top" => "homes#top"
  get "about" => "homes#about"
  root "homes#top"
end
