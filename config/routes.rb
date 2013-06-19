Strobehub::Application.routes.draw do
  root :to => 'static_pages#index'
  
  resources   :users
  resources   :tracks
  resources   :repositories, :except => :index do
    resources :versions, :except => [:edit, :update, :create]
  end
  resources   :tags, :only => [:index, :show]

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#login'
  get   '/logout' => 'sessions#logout'
  post	'/repositories/:repository_id/versions/:id' => 'versions#update', :as => "update_version"
  post  '/repositories/:repository_id/versions/:id/new' => 'versions#create', :as => "spork_version"
  get   '/repositories/:repository_id/versions/:id/history' => 'versions#history', :as => "version_history"


end
