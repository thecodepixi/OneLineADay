Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'
 
  post '/login', controller: 'users', action: 'login'

  post '/logout', controller: 'users', action: 'logout'
  
  resources :users do 
    resources :journals, only: :index
  end 

  resources :journals, except: :index do
    resources :days 
  end

end
