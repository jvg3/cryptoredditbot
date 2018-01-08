Rails.application.routes.draw do
  root 'coins#index'
  resources :coins, only: [:create, :index]
  resources :mentions, only: [:index]
end