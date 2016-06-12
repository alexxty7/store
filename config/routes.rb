Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'home#index'

  resources :books, only: [:index, :show]
  resources :categories, only: :show

  resources :orders, only: [:show, :edit, :update] do
    post :add_item, on: :collection
  end

  resources :order_items, only: :destroy
  resources :checkout, only: [:show, :update]

  get '/cart', to: 'orders#edit', as: :cart
  patch '/cart/empty', to: 'orders#empty', as: :empty_cart
end
