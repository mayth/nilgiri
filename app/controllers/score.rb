Nilgiri::App.controllers :score do
  get :index do
    @recent = Score.order(updated_at: :desc).limit(20)
    render 'score/index'
  end

  get :new do
    @machines = Machine.all.map {|m| [m.name, m.slug]}
    @current_season = Time.now.strftime('%Y%m')
    render 'score/new'
  end

  post :create do
  end

end
