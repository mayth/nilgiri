Nilgiri::App.controllers :post do
  get :index do
    @posts = Post.all
    render 'post/index'
  end

  get :show, with: :id do
    begin
      @post = Post.find(params[:id])
      render 'post/show'
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

end
