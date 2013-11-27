require 'bundler/setup'
Bundler.require(:default, :assets)
require 'rake/sprocketstask'

Rake::SprocketsTask.new do |t|
  root = File.join(Dir.pwd, 'app')
  env = Sprockets::Environment.new(root)
  env.append_path 'assets/javascripts'
  env.append_path 'assets/stylesheets'
  env.append_path 'assets/images'
  if defined?(YUI)
    env.css_compressor = YUI::CssCompressor.new
  else
    puts 'CSS compression is disabled.'
  end
  if defined?(Uglifier)
    env.register_postprocessor 'application/javascript', ::Sprockets::JSMinifier
  else
    puts 'Javascript minification is disabled.'
  end
  t.environment = env
  t.output = './public/assets'
  t.assets = %w( application.js application.css )
end
