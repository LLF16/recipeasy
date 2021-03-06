Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :ingredients, only: :index
  resources :recipes, only: [:index, :show] do
    resources :measurement_shopping_lists, only: :create, module: :shopping_lists
  end
  resources :cooking_sessions, only: :show
  resources :profiles, only: [:show]
  resources :shopping_lists, only: [:show] do
    resources :recipes, only: :destroy, module: :shopping_lists
    member do
      get 'send_email'
    end
  end
  resources :measurement_shopping_lists, only: [:destroy]
  resources :searches, only: :index
  namespace :search do
    resources :ingredients, only: :index
  end
end
