Nilgiri::App.controllers :score do
  before do
    @page_id = 'score'
  end

  get :index do
    @recent = Score.order('updated_at DESC').limit(20)
    render 'score/index'
  end

  get :new do
    @score = Score.new
    @machines_option = Machine.all.map {|m| [m.name, m.id]}
    render 'score/new'
  end

  post :create do
    @machines_option = Machine.all.map {|m| [m.name, m.id]}

    score = params[:score]
    # Authorize player
    player_name, password =
      score.delete('player_name'), score.delete('password')
    begin
      player = Player.authorize(player_name, password)
    rescue ActiveRecord::RecordNotFound
      flash.now[:warning] = "The player was not found."
      render 'score/new'
    end

    # get season
    begin
      season = Season.find(score[:season_id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:warning] = "The season was not found."
      render 'score/new'
    end
    
    # get music
    begin
      music = Music.find(score[:music_id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:warning] = "The music was not found."
      render 'score/new'
    end

    # Save score
    @score = player.register_score(season, music, score['difficulty'], Float(score['score']), score['playstyle'])
    if @score.save
      flash[:info] = "Your score has been successfully submitted."
      redirect url(:score, :index)
    else
      flash.now[:warning] = "Failed to save your score."
      render 'score/new'
    end
  end

end
