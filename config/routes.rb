Strobehub::Application.routes.draw do
  root :to => 'static_pages#index'
  
  resources   :users
  resources   :tracks
  resources   :repositories do
    resources :versions
  end

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#login'
  get   '/logout' => 'sessions#logout'
  post	'/repositories/:repository_id/versions/:id' => 'versions#update'

end
