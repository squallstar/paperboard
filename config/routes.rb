Paperboard::Application.routes.draw do

  namespace :settings do
    get "profile" => "profile#index"
    patch "profile" => "profile#update"

    get "account" => "account#index"
    patch "account" => "account#update"
    delete "account" => "account#destroy"

    get "organizations" => "organizations#index"
    delete "organizations/:id" => "organizations#leave", as: :leave_organizations

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
    member do
      get 'members' => 'organizations#members'
      delete 'members/:user' => 'organizations#remove_member', as: :remove_member
    end

    collection do
      get 'join/:key' => 'organizations#join_team', as: :join_team
    end

    resources :teams do
      member do
        post 'members' => 'teams#add_member', as: :add_member
        delete 'members/:member' => 'teams#remove_member', as: :remove_member
        delete 'invite/:key' => 'teams#remove_invite', as: :remove_invite
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
  get   "login"  => "auth#login", as: :login
  get   "logout" => "auth#logout", as: :logout
  post  "login"  => "auth#login"
  match "forgot-password" => "auth#forgot_password", via: [:get, :post], as: :forgot_password
  match "reset-password/:id/:request_token" => "auth#reset_password", via: [:get, :patch], as: :reset_password

  # User Signup
  match "signup" => "auth#signup", via: [:get, :post], as: :signup
  get   "signup/complete" => "auth#signup_complete", as: :signup_complete
  get   "signup/confirm/:id/:key" => "auth#signup_confirm_email", as: :signup_confirm_email

  # Generic root url (dashboard) for logged in users
  get "projects" => 'projects/projects#index', as: :dashboard

  # Custom error routes
  get '404', to: 'errors#404'
  get '422', to: 'errors#422'
  get '500', to: 'errors#500'

  root 'website#index'

end