Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'
 
  post '/login', controller: 'users', action: 'login'

  post '/logout', controller: 'users', action: 'logout'
  
  resources :users do 
    resources :journals, only: [:index, :show, :new, :create] 
  end 

  resources :journals, only: [:edit, :update, :destroy] do
    resources :moods, only: [:index, :show]
    resources :days, only: [:index, :show, :new, :create]
  end

  resources :days, only: [:edit, :update, :destroy]

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

end

# Routes I Want: 
# USERS
# get / => users#login or users#show
# get /users/:id => users#show
# delete /users/:id => users#destroy
# get /users/:id/edit => users#edit
# put/patch /users/:id => users#update 
# get /users/new => users#new
# post /users => users#create
# USERS JOURNALS
# get /users/:user_id/journals => journals#index 
# get /users/:user_id/journals/new => journal#new 
# post /users/:user_id/journals => journal#create 
# get /users/:user_id/journals/:id => journals#show
# USERS MOODS
# get /users/moods => moods#index 
# get /users/moods/:id => moods#show 
# JOURNALS
# get /journals/:id/edit => journal#edit
# put/patch /journals/:id => journal#update 
# delete /journals/:id => journals#destroy 
# JOURNALS DAYS
# get /journals/:id/days => days#index
# get /journals/:journal_id/days/:id => days#show 
# get /journals/:journal_id/days/new => days#new 
# post /journals/:journal_id/days => days#create 
# DAYS
# get days/:id/edit => days#edit 
# put/patch days/:id => days#update 
# delete days/:id => days#destroy 
