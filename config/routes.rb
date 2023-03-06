Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'games#index'
  post '/users', to: 'games#create_user'
  get '/answer', to: 'games#answer_round'
end
