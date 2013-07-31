helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic Realm="Nilgiri Admin"'
    halt 401, "Authentication Required\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [settings.admin_id, settings.admin_pass]
  end
end

before '/admin' do
  protected!
end

get '/admin' do
  haml :admin
end

get '/admin/news/new' do
  haml :admin_news_new
end

post '/admin/news/new' do
  title = (params[:title] || '').strip
  body = (params[:body] || '').strip
  raise ValidationError, 'No title given.' if title.empty?
  raise ValidationError, 'No body given.' if body.empty?

  t = Time.now
  title = CGI.escapeHTML(title)
  body = CGI.escapeHTML(body)
  Post.new(title: title, body: body, posted_at: t, updated_at: t).save!
  redirect '/admin/news/list'
end

get '/admin/news/list' do
  haml :admin_news_list
end

get '/admin/news/:id' do
  @post = Post.find(params[:id])
  haml :admin_news_individual
end

post '/admin/news/:id' do
  title = (params[:title] || '').strip
  body = (params[:body] || '').strip
  raise ValidationError, 'No title given.' if title.empty?
  raise ValidationError, 'No body given.' if body.empty?
  post = Post.find(params[:id])

  t = Time.now
  title = CGI.escapeHTML(title)
  body = CGI.escapeHTML(body)
  post.title = title
  post.body = body
  post.updated_at = t
  post.save!
  redirect "/admin/news/#{params[:id]}"
end

delete '/admin/news/:id' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/admin/news/list'
end

post '/admin/season' do
  halt 500, 'No season given.' if (!params[:season] || params[:season].strip.empty?)
  season = Setting.find_or_create_by(key: :season)
  season.value = params[:season]
  settings.season = params[:season]
  season.save!
  redirect '/admin'
end
