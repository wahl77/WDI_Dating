RailsProject::Application.routes.draw do


  post '/pokes/:id(.:format)' => 'pokes#create', as: :new_poke
  post '/poke_back/:id(.:format)' => 'pokes#poke_back', as: :poke_back
  put '/pokes/:id(.:format)' => 'pokes#update', as: :edit_poke



  resources :subscriptions, :only => [:new, :create]
  resources :users
  resources :sessions
  resources :messages

  get "matches/show" => 'matches#show', as: :match

  get 'logout' => 'sessions#destroy', as: :logout
  root :to => 'static_pages#index'

  post '/search' => 'matches#search', as: :search

end
