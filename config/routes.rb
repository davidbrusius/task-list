Rails.application.routes.draw do
  resources :tasks
  devise_for :users
  resources :lists

  root 'lists#index'
end
