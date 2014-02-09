set :rails_env, 'staging_squallstar'
set :keep_releases, 5
set :assets_role, [:web, :app, :worker]

server 'squallstar.it', user: 'capistrano', password: 'wE5rUfreJESwAFr5BuswatRudr3cEnas', roles: %w{web app db}, port: 2195, primary: true

set :deploy_to, "/home/source/rails/paperboard-staging"

set :assets_prefix, "assets"


namespace :deploy do
  desc 'Import plans'
  task :import_plans do
    on roles(:db), in: :sequence, wait: 5 do
      within release_path do
        run("bundle exec rake paymill:import_plans RAILS_ENV=staging_squallstar")
      end
    end
  end

  before :publishing, :import_plans
end