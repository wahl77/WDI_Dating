RailsProject::Application.routes.draw do
  get "messages/index"

  get "messages/new"

  get "matches/show" => 'matches#show', as: :match

  resources :users
  resources :sessions
  resources :messages


  get 'logout' => 'sessions#destroy', as: :logout
  root :to => 'static_pages#index'

end
