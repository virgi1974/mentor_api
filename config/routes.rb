Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api-mentor'  do 
    scope module: :v1 do
      resources :users, except: [:new, :edit] do
        resources :conversations, except: [:new, :edit] do
          resources :comments, except: [:new, :edit]
        end
      end      
    end
  end

 get :token, controller: 'application'

 root :to => "users#index"

end
