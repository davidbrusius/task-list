Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :lists do
    get ':list_scope', action: :index, on: :collection,
                       constraints: { list_scope: /private|public/ }
  end

  root 'lists#index'
end
