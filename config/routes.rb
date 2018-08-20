Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users
  root to: 'ingredients#index'
  resources :recipes, only: [:index]
  resources :profiles, only: [:show]
  resources :cooking_sessions, only: :show
end
