Rails.application.routes.draw do
  root to: 'home#show'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :brands
  resources :categories
  resources :stores
  resources :products
  resources :product_media
  resources :variants, except: %i(index)
  resources :reports

  get 'search', to: 'search#multi', as: 'search'
end
