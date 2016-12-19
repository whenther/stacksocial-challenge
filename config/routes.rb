Rails.application.routes.draw do
  resources :tweet_streams

  get '/signup', to: 'users#new'
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root 'tweet_streams#index'
end
