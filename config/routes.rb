Rails.application.routes.draw do
  root to:'home#index'

  resources :authentication, only: [:create]
  resources :widgets, only: [:index, :create, :new]
  resources :users, only: [:create, :new] 
end
