Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, only: :show

  resources :orders, only: [:show, :edit, :update] do
    post :add_item, on: :collection
  end

  scope module: 'users' do
    resource :account do
      patch 'update_password'
    end
  end

  resources :order_items, only: :destroy

  resources :checkout, only: [:index, :show, :update]

  get '/cart', to: 'orders#edit', as: :cart
  patch '/cart/empty', to: 'orders#empty', as: :empty_cart
end
