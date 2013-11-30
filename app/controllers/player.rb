Nilgiri::App.controllers :player do
  get :index do
    @players = Player.all
    render 'player/index'
  end

  get :show, with: :id do
    begin
      @player = Player.find(params[:id])
      render 'player/show'
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "Player #{params[:id]} was not found."
      halt 404
    end
  end

  get :new do
    @player = Player.new
    render 'player/new'
  end

  post :create do
    @player = Player.new(params[:player])
    if @player.save
      flash[:success] = "Your account \"#{@player.name}\" has been successfully created."
      redirect(url(:player, :edit, id: @player.id))
    else
      flash.now[:warning] = "Failed to create your account!"
      render 'player/new'
    end
  end

  get :edit, with: :id do
    begin
      @player = Player.find(params[:id])
      render 'player/edit'
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "Player #{params[:id]} was not found."
      halt 404
    end
  end

  put :update, with: :id do
    begin
      @player = Player.find(params[:id])
      if @player.update_attributes(params[:player])
        redirect(url(:player, :edit, id: @player.id))
      else
        flash.now[:alert] = "Failed to update the account."
        render 'player/edit'
      end
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "Player #{params[:id]} was not found."
      halt 404
    end
  end

  delete :destroy, with: :id do
    begin
      player = Player.find(params[:id])
      if player.destroy
      else
        flash.now[:alert] = "Failed to delete the account."
      end
      redirect url(:player, :index)
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "Player #{params[:id]} was not found."
      halt 404
    else
      flash.now[:alert] = 'Something went wrong.'
      halt 500
    end
  end
end
