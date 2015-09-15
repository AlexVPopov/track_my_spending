Rails.application.routes.draw do
  resources :expenses

  resources :tags, only: :index

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  devise_scope :user do
    authenticated(:user) { root 'expenses#index', as: :authenticated_root }

    unauthenticated { root 'devise/sessions#new', as: :unauthenticated_root }
  end
end
