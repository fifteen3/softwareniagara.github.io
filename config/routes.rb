Softwareniagara::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]

  namespace :admin do
    resources :posts
    resources :events
    resources :users, :except => [:new, :create]
    resources :emails
    resources :applicants
  end
end
