require 'digest/sha2'
require 'cgi/util'

class ValidationError < StandardError; end

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
    settings.sprockets.register_postprocessor('application/javascript', Sprockets::StrictMode) if development?
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
  haml :register
end

post '/score/register' do
end

get '/signup' do
  haml :signup
end

post '/signup' do
  ### Validation
  raise ValidationError, 'Invalid character in ID' unless params[:name] =~ /^[0-9a-zA-Z_]+$/
  raise ValidationError, 'Password must not be empty' if params[:pass].empty?
  raise ValidationError, 'Invalid character in Twitter ID' unless params[:twitter_id].empty? || params[:twitter_id] =~ /^[0-9a-zA-Z_]+$/
  begin
    p = Player.find_by(name: params[:name])
  rescue
  end
  halt 500, 'Your ID is already taken...' if p

  ### Escape
  @screen_name = CGI.escapeHTML(params[:screen_name].empty? ? params[:name] : params[:screen_name])

  # Calculate digest
  name_hash = Digest::SHA256.hexdigest(params[:name])
  pass_hash = Digest::SHA256.hexdigest(params[:pass])
  pass = Digest::SHA256.hexdigest(name_hash + pass_hash)

  # Registration
  p = Player.new(name: params[:name], screen_name: @screen_name, pass: pass, twitter_id: params[:twitter_id])
  p.save!

  haml :signup_ok
end

error ValidationError do
  haml :validation_error
end
