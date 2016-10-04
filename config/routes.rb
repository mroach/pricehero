Rails.application.routes.draw do
  root to: 'home#index'

  resources :brands
  resources :categories
  resources :stores
  resources :products
  resources :variants
  resources :reports
end
