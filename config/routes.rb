Rails.application.routes.draw do
  devise_scope :user do
    authenticated(:user) { root 'expenses#index', as: :authenticated_root }

    unauthenticated { root 'devise/sessions#new', as: :unauthenticated_root }
  end

  resources :expenses

  resources :tags, only: :index

  devise_for :users
end
