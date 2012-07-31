Softwareniagara::Application.routes.draw do
  authenticated :user do
    root :to => 'frontend/home#index'
  end
  root to: 'frontend/home#index'
  devise_for :users
  resources :users, only: [:show, :index]

  namespace :admin do
    resources :posts
    resources :events
    resources :users, except: [:new, :create]
    resources :emails
    resources :applicants
  end

  scope module: 'frontend' do
    resources :home, only: [:index]
  end
end
