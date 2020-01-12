Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'
  get '/login', controller: 'users', action: 'login'
  post '/login', controller: 'users', action: 'login'
  resources :users do 
    resources :journals do
      resources :days, only: :index
    end 
  end 

  resources :days, except: :index

end
