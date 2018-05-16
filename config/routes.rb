Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  resources :sessions, only: [:create]
  resources :chatrooms, only: [:show]
  resources :conversations, only: [:show, :new, :create]
end
