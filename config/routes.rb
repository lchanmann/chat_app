Rails.application.routes.draw do
  root 'chatrooms#index'
  resources :chatrooms, only: [:index, :show]
end
