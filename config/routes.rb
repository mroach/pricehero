Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :brands
  resources :categories
  resources :stores
  resources :products
  resources :product_media
  resources :variants
  resources :reports
end
