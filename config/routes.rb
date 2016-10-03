Rails.application.routes.draw do
  resources :brands
  resources :categories
  resources :stores
  resources :products
  resources :variants
  resources :reports
end
