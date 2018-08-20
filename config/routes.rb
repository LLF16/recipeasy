Rails.application.routes.draw do
  devise_for :users
  root to: 'ingredients#index'
  resources :recipes, only: [:index]
end
