Nilgiri::App.controllers :machine do
  get :index do

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
end
