Rails.application.routes.draw do
  root 'daily_menus#index'

  resources :daily_menus, only: [:index, :show] do
    get '/order_items/new', to: 'order_items#new'
    post '/order_items', to: 'order_items#create'
  end
  
  namespace :admin do
    root 'daily_menus#index'
    resources :daily_menus
    resources :users, only:[:index, :show]
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
