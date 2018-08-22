Rails.application.routes.draw do
  get 'search/index'
  devise_for :users
  root to: 'ingredients#index'
  resources :recipes, only: [:index, :show]
  resources :cooking_sessions, only: :show
  resources :profiles, only: [:show]
  resources :shopping_lists, only: [:show] do
    resources :recipes, only: :destroy, module: :shopping_lists
  end
  resources :measurement_shopping_lists, only: [:destroy]
  resources :searches, only: :index
end
