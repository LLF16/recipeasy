Rails.application.routes.draw do
  devise_for :users
  root to: 'ingredients#index'
  resources :recipes, only: [:index, :show ]
  resources :cooking_sessions, only: :show
  resources :profiles, only: [:show]
  resources :shopping_lists, only: [:show]
  resources :measurement_shopping_lists, only: [:destroy]
end
