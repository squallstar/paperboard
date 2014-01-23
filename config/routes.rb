Paperboard::Application.routes.draw do

  namespace :settings do
    get "profile" => "profile#index"
    patch "profile" => "profile#update"

    get "account" => "account#index"
    patch "account" => "account#update"
  end

  namespace :v1, format: :json do
    get "suggestions/people" => "suggestions#people"
  end

  # User
  resources :users, only: [:show]

  # Organizations
  resources :organizations, module: 'organizations' do
    resources :members
    resources :teams
  end

  # Projects
  resources :projects, module: 'projects' do
    resources :invites do
      collection do
        get 'accept/:key' => 'invites#accept', as: :accept
      end
    end

    resources :members
  end

  # Sessions
  get  "login"  => "auth#login", as: :login
  get  "logout" => "auth#logout", as: :logout
  post "login"  => "auth#login"
  get  "signup" => "auth#signup", as: :signup

  root 'projects/projects#index'

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
