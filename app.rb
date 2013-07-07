set :sprockets, Sprockets::Environment.new

configure do
  Mongoid.load!('./config/mongoid.yml')
  Sprockets::Helpers.configure do |config|
    config.environment = settings.sprockets
    config.prefix = '/assets'
    config.digest = true
  end
  settings.sprockets.append_path 'assets/javascripts'
  settings.sprockets.append_path 'assets/stylesheets'
  if production?
    settings.sprockets.js_compressor = YUI::JavaScriptCompressor.new(munge: true, optimize: true)
    settings.sprockets.css_compressor = YUI::CssCompressor.new
  end
end

helpers Sprockets::Helpers

Dir.glob('./models/*.rb').each do |s|
  require_relative s
end

get '/' do
  haml :index
end

get '/score/register' do
end

get '/signup' do
end
