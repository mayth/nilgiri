require 'bundler'
require 'sinatra'
Bundler.require(:default, Sinatra::Application.environment)

require './app.rb'
require 'newrelic_rpm'

map '/assets' do
  run Sinatra::Application.sprockets
end

map '/' do
  run Sinatra::Application
end
