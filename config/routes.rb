Rails.application.routes.draw do
  root 'daily_menus#index'
  resources :daily_menus, only: [:index, :show]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
