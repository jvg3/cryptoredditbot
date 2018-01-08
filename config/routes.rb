Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'coins#index'
  resources :coins, only: [:create, :index]
  resources :mentions, only: [:index]
end