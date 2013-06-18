Strobehub::Application.routes.draw do
  root :to => 'static_pages#index'
  
  resources   :users
  resources   :tracks
  resources   :repositories do
    resources :versions
  end

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'static_pages#new'
  post  '/login'  => 'static_pages#login'
  get   '/logout' => 'static_pages#logout'
  post	'/repositories/:repository_id/versions/:id' => 'versions#update'

end
