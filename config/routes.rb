Rails.application.routes.draw do
  root 'products#index'
  resources :transactions
  resources :products
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
