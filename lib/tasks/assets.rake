require 'bundler/setup'
Bundler.require(:default, :assets)
require 'rake/sprocketstask'
require 'fileutils'

Rake::SprocketsTask.new do |t|
  t.name = :prebuild
  root = File.join(Dir.pwd, 'app')
  env = ::Sprockets::Environment.new(root)
  %w(javascripts stylesheets images).each do |path|
    env.append_path "assets/#{path}"
  end
  if defined?(YUI)
    env.css_compressor = YUI::CssCompressor.new
  end
  if defined?(Uglifier)
    env.register_postprocessor 'application/javascript', ::Sprockets::JSMinifier
  end
  t.environment = env
  t.output = 'public/assets'
  t.assets = %w(.js .css).map{|ext| "application#{ext}"}
end

desc 'Deploy prebuilt assets'
task :assets => [:prebuild, :assets_ready]

desc 'Rename to ready to serve prebuilt assets'
task :assets_ready do
  asset_dir = File.join(Dir.pwd, 'app/assets/prebuilt')
  prebuilt_dir = File.join(Dir.pwd, 'public/assets')
  asset_name = "application"
  asset_exts = %w(.js .css)
  unless Dir.exists? asset_dir
    Dir.mkdir asset_dir
  end
  asset_exts.each do |ext|
    paths = Dir["#{File.join(prebuilt_dir, asset_name)}-*#{ext}"]
    if paths.any?
      path = paths.first
      FileUtils.cp(path, File.join(asset_dir, asset_name + ext))
    end
  end
  # FileUtils.rm_r(prebuilt_dir, secure: true)
end

desc 'Remove prebuilt assets'
task :assets_remove do
  asset_dir = File.join(Dir.pwd, 'app/assets/prebuilt')
  FileUtils.rm_r(asset_dir, secure: true)
end
