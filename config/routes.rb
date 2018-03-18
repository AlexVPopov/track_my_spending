# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :expenses

  resources :tags, only: :index

  devise_scope :user do
    authenticated :user do
      root 'expenses#index', as: :authenticated_root
    end

    authenticated :user, ->(u) { u.admin? } do
      ActiveAdmin.routes(self)
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get '*path' => redirect('/')
end
