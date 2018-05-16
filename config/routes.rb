Rails.application.routes.draw do
  root 'home#index'
  resources :chatrooms, only: [:show]
  resources :conversations, only: [:show, :new, :create]
end
