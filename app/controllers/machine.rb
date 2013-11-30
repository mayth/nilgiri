Nilgiri::App.controllers :machine do
  get :index do

  end

  # /machine/difficulties/{id}.js
  get :difficulties, with: :id, provides: :js do
    begin
      machine = Machine.find(params[:id])
      machine.difficulties.to_json
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

  # /machine/playstyles/{id}.js
  get :playstyles, with: :id, provides: :js do
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
