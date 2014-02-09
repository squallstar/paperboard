set :rails_env, 'production_squallstar'
set :keep_releases, 5
set :assets_role, [:web, :app, :worker]

server 'squallstar.it', user: 'capistrano', password: 'wE5rUfreJESwAFr5BuswatRudr3cEnas', roles: %w{web app db}, port: 2195, primary: true

set :deploy_to, "/home/source/rails/paperboard-production"

set :assets_prefix, "assets"