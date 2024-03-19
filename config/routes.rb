# frozen_string_literal: true

Rails.application.routes.draw do
  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end

  authenticated :user do
    constraints ->(req) { req.env['warden'].user.role == 'admin' } do
      root to: 'system/dashboard#index', as: :admin_root
    end

    root to: 'main/home#index', as: :authenticated_root
  end

  namespace :system do
    resources :users
  end

  namespace :main do
    resources :users, except: %i[index create new]
  end

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations',
    omniauth_callbacks: 'auth/omniauth_callbacks'
  }
end
