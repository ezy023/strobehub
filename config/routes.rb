Strobehub::Application.routes.draw do
  resources   :users
  resources   :tracks
  resources   :respositories do
    resources :versions
  end

  get   '/'       => 'static_pages#index'
  get   '/login'  => 'static_pages#login'
  post  '/login'  => 'static_pages#login'
  get   '/logout' => 'static_pages#logout'

end
