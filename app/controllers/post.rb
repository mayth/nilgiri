Nilgiri::App.controllers :post do
  get :index do
    @posts = Post.all
    render 'post/index'
  end

  get :show, with: :id do
  end

end
