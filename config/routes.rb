Rails.application.routes.draw do
  root 'daily_menus#index'

  resources :daily_menus, only: [:index, :show] do
    resources :orders
  end
  
  namespace :admin do
    root 'daily_menus#index'
    resources :daily_menus
    resources :users, only:[:index, :show]
  end
  
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
