source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

# Override the :github shortcut to use SSH to avoid the insecurity of git://
git_source(:github) { |repo| "git@github.com:#{repo}.git" }

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Auditing for ActiveRecord models
gem 'paper_trail', '~> 5.2'

# Doesn't destroy records. Hides them using a deleted_at column
gem 'paranoia', '~> 2.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1'

# Use Slim as the templating engine. Better than ERB
gem 'slim-rails'

# Friendly URLs using slugs
gem 'friendly_id'

# Fancy money and currency handling
gem 'money-rails'

# Validator for UPC/EAN/GTIN
gem 'gtin'

# Authentication
gem 'devise'
gem 'omniauth-facebook'

# Authorization
gem 'pundit'

# Handles unit conversion
gem 'ruby-units'

# Model hierarchy. i.e. nested categories
gem 'closure_tree'

# Country picker
gem 'country_select'

# Image processing (requires Imagemagick be installed)
gem 'mini_magick'

# Attachment handler
gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'

# Amazon S3
gem 'carrierwave-aws'

# Exception logging
gem 'rollbar'

gem 'turbolinks'

# Advanced text searching
gem 'pg_search'

# Easy integration of Bower components with the Rails pipeline
gem 'bower-rails'

# Form builder
gem 'simple_form'

group :development, :test do
  # Load ENV vars from .env
  gem 'dotenv-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Spec testing
  gem 'rspec-rails'

  # Code coverage analysis
  gem 'simplecov', require: false

  # Acceptance testing
  gem 'capybara'

  # Generates fake test data
  gem 'faker'
end

group :development do
  # Make the Rails console heaps better
  gem 'pry-rails'

  # Notify about guard results (OS X)
  gem 'terminal-notifier-guard', '~> 1.6'

  # Spec output formatting
  gem 'fuubar'

  # Automatically run tests when files change
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-pow', require: false

  # Enforce Ruby coding style
  gem 'rubocop', require: false

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Matchers for RSpec
  gem 'shoulda-matchers', require: false

  # Restore the 'its' shorthand method that was extracted from rspec-core
  gem 'rspec-its'

  # Cleans up the database after tests
  gem 'database_cleaner'

  # Object factory
  gem 'factory_girl_rails'

  # Better matchers for Pundit
  gem 'pundit-matchers', '~> 1.1.0'
end
