# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resources :authentication, only: [:create] do
    delete :destroy, on: :collection
  end
  resources :widgets, only: %i[index create new]
  resources :users, only: %i[create new show]
end
