Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :orders do
    get 'confirm', on: :collection
    get 'shipping', on: :collection
  end
  resource :carts, only: [:show] do
    get 'empty', on: :collection
  end
  resources :order_items
  resources :orders
  resources :items
  resources :promotions
  resources :categories
  resources :brands

  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
