Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  resources :sessions, only: :create
  concern :messaging do
    resources :messages, only: :index
  end
  resources :chatrooms, only: :show, concerns: :messaging
  resources :conversations, only: [:show, :new, :create], concerns: :messaging
end
