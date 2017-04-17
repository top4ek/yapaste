# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :edit do
    get :fork, on: :member
  end

  resources :comments, only: :create
end
