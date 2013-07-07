require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'mongoid'

configure do
  Mongoid.load!('./config/mongoid.yml')
end

Dir.glob('./models/*.rb').each do |s|
  require_relative s
end

get '/' do
  haml :index
end
