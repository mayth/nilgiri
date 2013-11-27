Nilgiri::App.controllers :base do
  get :index, :map => '/' do
    @machines = Machine.all
    @top_post = Post.first
    @posts = Post.offset(1).limit(5)
    @is_more_posts = Post.count > 6
    @current_season = '201311'
    render 'base/index'
  end
end
