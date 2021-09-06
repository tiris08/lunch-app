Rails.application.routes.draw do
  root 'daily_menus#index'

  resources :daily_menus, only: [:index, :show]
  
  namespace :admin do
    
    resources :daily_menus
    resources :users, only:[:index, :show]
    root 'daily_menus#index'
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
