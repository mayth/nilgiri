Nilgiri::App.controllers :machine do
  get :index do
    @machines = Machine.all
    render 'machine/index'
  end

  get :show, with: :slug do
  end

  # /machine/difficulties/{id}.json
  get :difficulties, with: :id, provides: :json do
    begin
      machine = Machine.find(params[:id])
      machine.difficulties.to_json
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

  # /machine/playstyles/{id}.json
  get :playstyles, with: :id, provides: :json do
    begin
      machine = Machine.find(params[:id])
      if machine.playstyles.present?
        machine.playstyles.to_json
      else
        nil.to_json
      end
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

  get :musics, with: :id, provides: :json do
    begin
      machine = Machine.find(params[:id])
      machine.musics.to_json
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

  get :musics, with: [:id, :season_id], provides: :json do
    begin
      machine = Machine.find(params[:id])
      season = Season.find(params[:season_id])
      machine.musics_for(season).to_json
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end
end
