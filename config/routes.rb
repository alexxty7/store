Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :books, only: [:index, :show]
  resources :categories, only: :show

  resources :orders, only: [:show, :edit, :update] do
    post :add_item, on: :collection
  end

  resources :order_items, only: :destroy
  resources :checkout, only: [:show, :update]

  get '/cart', to: 'orders#edit', as: :cart
  put '/cart/empty', to: 'orders#empty', as: :empty_cart
end
