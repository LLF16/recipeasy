Rails.application.routes.draw do
  devise_for :users
  root to: 'ingredients#index'
  resources :recipes, only: [:index]
  resources :cooking_sessions, only: :show
  resources :profiles, only: [:show]
  # resources :users do
    resources :shopping_lists, only: [:show]
  # end
  resources :measurement_shopping_lists, only: [:destroy]
end
