require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    user_id = request.session['warden.user.user.key'][0][0]
    User.find_by(id: user_id)&.is_admin?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/admin/sidekiq", constraints: AdminConstraint.new
  
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
    resources :orders, only: %i[index]
  end

  devise_for :users,
             controllers: { registrations:      'registrations',
                            omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
