source 'https://rubygems.org'

# Server requirements
# gem 'thin' # or mongrel

# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'sass'
gem 'slim'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'pg', :group => 'production' # require pg only for production

# Padrino Stable Gem
gem 'padrino', '0.11.4'

group :development, :test do
  gem 'sqlite3' # use sqlite3 for development/test
end

# Test requirements
group :test do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
end
