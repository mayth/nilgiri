source 'https://rubygems.org'

# specify Ruby version
ruby '2.0.0'

# Server requirements
gem 'unicorn'

# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'sass'
gem 'slim'
gem 'activerecord', '>= 3.1', :require => 'active_record'

# Padrino Stable Gem
gem 'padrino', '0.11.4'

# Key Derivation Function
gem 'scrypt'

### assets pipeline
gem 'padrino-sprockets', require: 'padrino/sprockets'
group :assets do
  gem 'uglifier'
  gem 'yui-compressor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'pg'  # require pg only for production
end

group :development, :test do
  gem 'sqlite3' # use sqlite3 for development/test
end

# Test requirements
group :test do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
end
