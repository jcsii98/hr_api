Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users
  get '/remember_me', to: 'users#remember_me'

  mount_devise_token_auth_for 'Admin', at: 'admin_auth'
  as :admin do
    # Define routes for Admin within this block.
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :sites

  resources :shifts

  resources :user_payslips

  resources :expenses

  resources :site_payslips

  post '/upload_to_s3', to: 's3_test#upload_to_s3'
  # Defines the root path route ("/")
  # root "articles#index"
end
