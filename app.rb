require 'digest/sha2'
require 'cgi/util'
require 'json'

class ValidationError < StandardError; end

set :sprockets, Sprockets::Environment.new

MACHINES = {
  iidx: 'beatmania IIDX 20 tricoro',
  popn: "pop'n music Sunny Park",
  gfg:  'GITADORA GuitarFreaks (GUITAR)',
  gfb:  'GITADORA GuitarFreaks (BASS)',
  dm:   'GITADORA DrumMania',
  ddr:  'DanceDanceRevolution',
  jb:   'jubeat saucer',
  rb:   'REFLEC BEAT colette',
  sdvx: 'SOUND VOLTEX II -infinite infection-',
  dea:  'DanceEvolution ARCADE',
  ftt:  'ミライダガッキ',
  mm:   'maimai GreeN'
}

DIFFICULTIES = {
  iidx: %w(NORMAL HYPER ANOTHER),
  popn: %w(NORMAL HYPER EX),
  gfg:  %w(BASIC ADVANCED EXTREME MASTER),
  gfb:  %w(BASIC ADVANCED EXTREME MASTER),
  dm:   %w(BASIC ADVANCED EXTREME MASTER),
  ddr:  %w(BEGINNER BASIC DIFFICULT EXPERT CHALLENGE),
  jb:   %w(BASIC ADVANCED EXTREME),
  rb:   %w(BASIC MEDIUM HARD),
  sdvx: %w(NOVICE ADVANCED EXHAUST INFINITE),
  dea:  %w(LIGHT STANDARD EXTREME MASTER STEALTH),
  ftt:  %w(ベーシック スーパー ウルトラ),
  mm:   %w(EASY BASIC ADVANCED EXPERT MASTER)
}

configure do
  set :admin_id, (ENV['ADMIN_ID'] || 'admin')
  set :admin_pass, (ENV['ADMIN_PASS'] ||'admin123')

  Mongoid.load!('./config/mongoid.yml')
  Sprockets::Helpers.configure do |config|
    config.environment = settings.sprockets
    config.prefix = '/assets'
    config.digest = true
  end
  settings.sprockets.append_path 'assets/javascripts'
  settings.sprockets.append_path 'assets/stylesheets'
  settings.sprockets.register_postprocessor('application/javascript', Sprockets::StrictMode) if development?
  if production?
    settings.sprockets.js_compressor = YUI::JavaScriptCompressor.new(munge: true, optimize: true)
    settings.sprockets.css_compressor = YUI::CssCompressor.new
  end
end

helpers Sprockets::Helpers
helpers do
  def pass_hash(id, pass)
    id_hash = Digest::SHA256.hexdigest(id)
    pass_hash = Digest::SHA256.hexdigest(pass)
    Digest::SHA256.hexdigest(id_hash + pass_hash)
  end

  def print_score(score)
    case score.score_type
    when :int
      Integer(score.score).to_s
    when :perc
      "#{Float(score.score)} %"
    else
      Float(score.score).to_s
    end
  end
end

Dir.glob('./models/*.rb').each do |s|
  require_relative s
end

require './admin.rb'

get '/' do
  @page_id = 'index'
  haml :index
end

get '/score/register' do
  @page_id = 'score_register'
  haml :register
end

post '/score/register' do
  registered_at = Time.now

  id = params[:id] || ''
  pass = params[:pass] || ''
  s_machine = params[:machine] || ''
  s_difficulty = params[:difficulty] || ''
  s_score = params[:score] || ''
  s_score_type = params[:score_type] || ''
  s_regist_tag = params[:target] || ''
  raise ValidationError, 'ID must not be empty.' if id.empty?
  raise ValidationError, 'Password must not be empty.' if pass.empty?
  raise ValidationError, 'Machine type must be chosen.' if s_machine.empty?
  raise ValidationError, 'Difficulty must be chosen.' if s_difficulty.empty?
  raise ValidationError, 'Score must not be empty.' if s_score.empty?
  raise ValidationError, 'Score type must not be empty.' if s_score_type.empty?
  raise ValidationError, 'Registration tag must be given.' if s_regist_tag.empty?
  ip_hash = pass_hash(id, pass)
  player = Player.find_by(pid: id)
  halt 500, "Player ID or Password is wrong." if !player || player.pass != ip_hash
  machine = s_machine.to_sym
  difficulty = s_difficulty.to_sym
  score = Float(s_score)
  score_type = s_score_type.to_sym
  regist_tag = s_regist_tag.to_sym
  c = player.scores.where(registration_target: regist_tag, machine: machine, difficulty: difficulty)
  if c.exists?
    s = c.first
    s.registered_at = registered_at
    s.score = score
    s.save!
  else 
    player.scores.create(
      registration_target: regist_tag,
      registered_at: registered_at,
      machine: machine,
      difficulty: difficulty,
      score: score,
      score_type: score_type)
  end
  haml :registered
end

get '/score/machine/:machine' do
  @machine = params[:machine].to_sym
  @season = Time.now.strftime('%Y%m')
  haml :score_machine
end

get '/signup' do
  haml :signup
end

post '/signup' do
  ### Validation
  raise ValidationError, 'Invalid character in ID' unless params[:id] =~ /^[0-9a-zA-Z_]+$/
  raise ValidationError, 'Password must not be empty' if params[:pass].empty?
  raise ValidationError, 'Invalid character in Twitter ID' unless params[:twitter_id].empty? || params[:twitter_id] =~ /^[0-9a-zA-Z_]+$/
  begin
    p = Player.find_by(pid: params[:id])
  rescue
  end
  halt 500, 'Your ID is already taken...' if p

  ### Escape
  @screen_name = CGI.escapeHTML(params[:screen_name].empty? ? params[:id] : params[:screen_name])

  # Calculate digest
  pass = pass_hash(params[:id], params[:pass])

  # Registration
  p = Player.new(pid: params[:id], screen_name: @screen_name, pass: pass, twitter_id: params[:twitter_id])
  p.save!

  haml :signup_ok
end

error ValidationError do
  haml :validation_error
end
