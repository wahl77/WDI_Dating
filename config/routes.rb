RailsProject::Application.routes.draw do
  resources :users
  resources :sessions


  get 'logout' => 'sessions#destroy', as: :logout
  root :to => 'static_pages#index'
end
