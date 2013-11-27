require 'bundler/setup'
Bundler.require(:default, :assets)
require 'rake/sprocketstask'

require './lib/sass_initializer'
require './lib/assets'
require './app/app.rb'

Rake::SprocketsTask.new do |t|
  root = Nilgiri::App.root
  t.environment = Nilgiri::Assets::Environment.get root, true
  t.output = './public/assets'
  t.assets = %w( application.js application.css )
end
