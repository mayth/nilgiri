source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.1.8'
gem 'pg'
gem 'sass-rails'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'foundation-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'friendly_id', '~> 5.0.0'

gem 'foreman'
gem 'figaro'

group :doc do
  gem 'sdoc', require: false
end

gem 'rails_admin'

# Authentication
gem 'devise'
gem 'devise-encryptable'
gem 'devise-scrypt'

# Application Server
gem 'unicorn'

group :development do
  gem 'erb2haml'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'hirb'
  gem 'hirb-unicode'

  gem 'awesome_print'
  gem 'quiet_assets'

  # RSpec
  gem 'rspec-rails', '~> 2.14.0'
  gem 'rake_shared_context'
  gem 'database_rewinder'
  gem 'guard-rspec', '~> 4.3.0'
  gem 'factory_girl_rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :production do
  gem 'rails_12factor'
  # JS/CSS Compression
  gem 'uglifier', '>= 1.3.0'
  gem 'yui-compressor'
  # Monitoring
  gem 'newrelic_rpm'
end
