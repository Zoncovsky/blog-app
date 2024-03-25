# frozen_string_literal: true

Rails.application.routes.draw do
  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end

  authenticated :user do
    constraints ->(req) { req.env['warden'].user.role == 'admin' } do
      root to: 'system/dashboard#index', as: :admin_root
    end

    root to: 'main/posts#index'
  end

  namespace :system do
    resources :users
    resources :posts do
      member do
        put 'post_published'
        put 'cancel'
      end
    end
  end

  namespace :main do
    resources :users, except: %i[index create new]
    resources :posts do
      member do
        put 'post_published'
        put 'cancel'
      end
    end
  end

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations',
    omniauth_callbacks: 'auth/omniauth_callbacks'
  }
end
