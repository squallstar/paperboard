source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# SQL adapter type
gem 'sqlite3', :group => :development
gem 'pg', :group => :production
gem 'mysql2', :group => :production_squallstar

# Env files
gem 'dotenv-rails'

# New relic for heroku
gem 'newrelic_rpm', :group => :production

# Use SCSS for stylesheets
group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
end

# Template engine
gem "slim-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

group :development do
  # Quiet Assets turns off the Rails asset pipeline log
  gem 'quiet_assets', :group => :development

  # Eager loading
  gem 'bullet', :group => :development
end

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Multi thread
gem "puma" #, "~> 2.7"

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
