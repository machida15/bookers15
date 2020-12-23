Rails.application.routes.draw do

  root to: 'homes#top'

  get "/home/about" => "homes#about"
  devise_for :users
  resources :books, only:[:create, :index, :edit, :show, :update, :destroy]
  resources :users, only:[:index, :show, :edit, :update]
end
