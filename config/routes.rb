Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api-mentor'  do 
    scope module: :v1 do
      resources :comments, except: [:new, :edit]
      resources :conversations, except: [:new, :edit]
      resources :users, except: [:new, :edit]      
    end
  end

 get :token, controller: 'application'

end
