source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Config files
gem 'rails_config'

gem 'rack-cache', :groups => [:production, :production_squallstar]

# Memcache
gem 'dalli'
gem 'memcachier'

# Env files
gem 'dotenv-rails'

# Upload to S3
gem 'paperclip'
gem 'aws-sdk'

# Payments
gem 'paymill'

# Assets
gem 'sass-rails'
gem 'compass-rails', github: 'Compass/compass-rails'
gem 'unf'
gem 'asset_sync'

# Template engine
gem "slim-rails"

# Serializer for APIs
gem "active_model_serializers"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# For DB seed - we might move it to development environment at some point
gem 'faker'

group :development do
  # SQLite adapter
  gem 'sqlite3'

  # Quiet Assets turns off the Rails asset pipeline log
  gem 'quiet_assets'

  # Eager loading
  gem 'bullet'
end

group :production do
  # PostgreSQL adapter
  gem 'pg'

  # Heroku logs and assets
  gem 'rails_12factor'

  # New relic for heroku
  gem 'newrelic_rpm'
end

group :production_squallstar do
  # MySQL adapter
  gem 'mysql2'
end

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

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

# Multi thread app server
gem "puma"

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
