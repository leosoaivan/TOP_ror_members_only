Rails.application.routes.draw do
  root 'welcome#new'
    
  resources :users

  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get  '/posts/new', to: 'posts#new'
  post '/posts', to: 'posts#create'
  get  '/posts', to: 'posts#index'

end
