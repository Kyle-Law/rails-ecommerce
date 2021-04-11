Rails.application.routes.draw do
  resources :order_items
  resources :orders
  resources :items
  resources :promotions
  resources :categories
  resources :brands
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
