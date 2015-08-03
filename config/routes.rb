Rails.application.routes.draw do
  resources :expenses
  resources :tags, only: :index
  devise_for :users
  root 'expenses#index'
end
