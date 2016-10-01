Rails.application.routes.draw do
  resources :stores
  resources :products, shallow: true do
    resources :reports
  end
  resources :categories
  resources :brands

  # Allow an indexing of all reports here and in addition to under products
  resources :reports, only: %i(index)
end
