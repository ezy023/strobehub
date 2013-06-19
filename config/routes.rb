Strobehub::Application.routes.draw do
  root :to => 'static_pages#index'
  
  resources   :users do 
    member do 
      get :following, :followers
    end
  end
  resources   :tracks
  resources   :repositories do
    resources :versions, :except => [:edit, :update, :create]
  end

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#login'
  get   '/logout' => 'sessions#logout'
  post	'/repositories/:repository_id/versions/:id' => 'versions#update', :as => "update_version"
  post  '/repositories/:repository_id/versions/:id/new' => 'versions#create', :as => "spork_version"
  post '/follow' => 'relationships#create', :as => 'follow_user'
  post '/unfollow' => 'relationships#destroy', :as => 'unfollow_user'

end
