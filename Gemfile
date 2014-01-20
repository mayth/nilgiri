source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.0.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'foundation-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end

# Key Derivation Function
gem 'scrypt'

# Application Server
gem 'unicorn'

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
  gem 'rspec-rails'
  gem 'rake_shared_context'
  gem 'database_cleaner'
  gem 'guard-rspec'
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
