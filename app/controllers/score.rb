Nilgiri::App.controllers :score do
  get :index do
    @recent = Score.order(updated_at: :desc).limit(20)
    render 'score/index'
  end

  get :new do
  end

  post :create do
  end

end
