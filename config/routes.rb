Paperboard::Application.routes.draw do

  namespace :settings do
    get "profile" => "profile#index"
    patch "profile" => "profile#update"

    get "account" => "account#index"
    patch "account" => "account#update"

    get "billing" => "billing#index"
    post "billing/subscribe/:plan_id" => "billing#subscribe", as: :billing_subscribe
    delete "billing/subscribe" => "billing#delete_subscription", as: :billing_subscribe_delete
  end

  namespace :v1, format: :json do
    get "suggestions/people" => "suggestions#people"
  end

  # User
  resources :users, only: [:show]

  # Organizations
  resources :organizations, module: 'organizations' do
    resources :members
    resources :teams do
      collection do
        post 'members' => 'teams#add_member'
        delete 'members/:id' => 'teams#remove_member'
      end
    end
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

  # Login/Logout sessions
  get  "login"  => "auth#login", as: :login
  get  "logout" => "auth#logout", as: :logout
  post "login"  => "auth#login"

  # User Signup
  match  "signup" => "auth#signup", via: [:get, :post], as: :signup
  get "signup/complete" => "auth#signup_complete", as: :signup_complete
  get "signup/confirm/:id/:key" => "auth#signup_confirm_email", as: :signup_confirm_email

  # Generic root url (dashboard) for logged in users
  get "projects" => 'projects/projects#index', as: :dashboard

  root 'website#index'

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
