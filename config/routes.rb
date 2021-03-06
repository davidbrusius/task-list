Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :lists do
    get ':list_scope', action: :index, on: :collection, as: :scoped,
                       constraints: { list_scope: /public|favorited/ }
    post :favorite
    delete :unfavorite
  end

  root 'lists#index'
end
