RailsProject::Application.routes.draw do


  resources :subscriptions, :only => [:new, :create]
  resources :users
  resources :sessions
  resources :messages

  get "matches/show" => 'matches#show', as: :match

  get 'logout' => 'sessions#destroy', as: :logout
  root :to => 'static_pages#index'

end
