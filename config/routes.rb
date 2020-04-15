# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :authentication, only: [:create] do
    delete :destroy, on: :collection
  end
  resources :widgets
  resources :users, only: %i[create new show] do
    get :edit, on: :collection
    put :update, on: :collection
  end

  resources :recover_password, only: [:new, :create]
end

