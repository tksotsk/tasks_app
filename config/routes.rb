Rails.application.routes.draw do
  resources :labels
  root 'sessions#new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
    
  end
end
