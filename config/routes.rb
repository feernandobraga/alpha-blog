Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'about', to: 'pages#about'

  resources :articles


  get "signup", to: "users#new"

  # I could use:
  # post "users", to: "users#create"
  # OR resources as per line below:

  resources :users, except: [:new]
  # this will give me all routes to the user controller apart from user#new because
  # I have already declared this one

end
