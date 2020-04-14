Rails.application.routes.draw do
  root to:'home#index'

  resources :authentication, only: [:create]
  resources :users, only: [:create, :new]
end
