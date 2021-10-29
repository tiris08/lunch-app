Rails.application.routes.draw do
  root 'daily_menus#index'

  resources :daily_menus, only: %i[index show] do
    resources :orders, except: %i[index show]
  end

  resources :orders, only: %i[index show]

  namespace :admin do
    root 'daily_menus#index'
    resources :daily_menus
    resources :users, only: %i[index show]
  end

  namespace :api do
    post 'user_token' => 'user_token#create'
    resources :orders, only: %i[index] 
  end

  devise_for :users,
             controllers: { registrations:      'registrations',
                            omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
