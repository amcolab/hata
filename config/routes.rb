Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'games#index'
  post '/users', to: 'games#create_user'
  get '/answer', to: 'games#answer_round', as: :answer_round
  get '/assessment', to: 'games#assessment_round'
  put '/answers/:id', to: 'answers#update', as: :update_answer
  get '/questions/:id/archived', to: 'games#archived_question', as: :archived_question
  get '/get_assessments', to: 'answers#get_assessment_path', as: :move_to_assessment
  put '/assessments', to: 'assessments#create'
  resources :answers, only: :index do
    post :aggregate_points, on: :collection
    get :result, on: :collection
  end
end
