Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users

  mount_devise_token_auth_for 'Admin', at: 'admin_auth'
  as :admin do
    # Define routes for Admin within this block.
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :sites

  resources :shifts
  # Defines the root path route ("/")
  # root "articles#index"
end
