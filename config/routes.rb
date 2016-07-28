Rails.application.routes.draw do
  get 'sessions/new'

  root 'static#index'
  get '/help', to: 'static#help'
  get '/register', to: 'users#new'
  #post '/register',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]

end
