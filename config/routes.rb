Rails.application.routes.draw do
  root 'coins#index'
  resources :coins, only: [:index]
  resources :mentions, only: [:index]
end