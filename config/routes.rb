Rails.application.routes.draw do
  resources :stores
  resources :reports
  resources :products
  resources :categories
  resources :brands
end
