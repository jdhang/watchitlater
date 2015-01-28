Rails.application.routes.draw do

  root "sessions#new"

  get '/dashboard', to: "sessions#dashboard"
  get '/register', to: 'users#new'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/watched_movies', to: 'sessions#watched_movies'

  resources :users, except: [:index, :show, :destroy]
  resources :movies do
    member do
      post 'watched', to: "movies#watched"
      post 'unwatch', to: "movies#unwatch"
    end
  end
  get 'ui(/:action)', controller: 'ui'
end
