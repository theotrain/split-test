Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/home', to: 'groups#vote'
  root to: 'sessions#new'

  get '/new_split_test', to: 'groups#new'
  post '/new_split_test', to: 'groups#create'
  get '/statistics', to: 'groups#statistics'

  resources :users, only: [:create, :new]
  resources :groups, except: [:show]
  get '/items/vote', to: 'items#vote'
  get '/vote', to: 'groups#vote'
end
