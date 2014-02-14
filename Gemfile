source 'https://rubygems.org'

ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Config files
gem 'rails_config'

gem 'rack-cache', :groups => [:production, :staging_squallstar, :production_squallstar]

# Memcache
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

# Nav links
gem 'nav_lynx'

# Serializer for APIs
gem "active_model_serializers"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :development do
  # Deploy
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'

  # SQLite adapter
  gem 'sqlite3'

  # Send local emails
  gem 'letter_opener'

  # Quiet Assets turns off the Rails asset pipeline log
  gem 'quiet_assets'

  # Eager loading
  gem 'bullet'
end

group :development, :test do
  # Tests
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # DB seed
  gem 'faker'
end

group :development, :production do
  # Multi thread app server
  gem "puma"
end

# Heroku
group :production do
  # PostgreSQL adapter
  gem 'pg'

  # Memcachier storage
  gem 'dalli'

  # Heroku logs and assets
  gem 'rails_12factor'

  # New relic for heroku
  gem 'newrelic_rpm'
end

# Squallstar Holland
group :staging_squallstar, :production_squallstar do
  # MySQL adapter
  gem 'mysql2'

  # RVM
  gem 'capistrano-rvm'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use debugger
# gem 'debugger', group: [:development, :test]
