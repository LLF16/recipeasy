Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :ingredients, only: :index
  resources :recipes, only: [:index, :show]
  resources :cooking_sessions, only: :show
  resources :profiles, only: [:show]
  resources :shopping_lists, only: [:show]
  resources :measurement_shopping_lists, only: [:destroy]
  resources :searches, only: :index
end
