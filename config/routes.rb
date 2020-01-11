Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "user#login"

  resources :user, except: :index do 
    resources :journals do
      resources :days, only: :index
    end 
  end 

  resources :days, except: :index

end
