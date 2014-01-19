Paperboard::Application.routes.draw do

  # User
  get "users/:username" => "users#show", as: :user

  # Organizations
  resources :organizations, module: 'organizations' do
    resources :members
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

  # Other
  get "dashboard/show"

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
