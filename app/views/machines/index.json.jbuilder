json.array!(@machines) do |machine|
  json.extract! machine, :id, :name, :slug, :difficulties, :playstyles
  json.url machine_url(machine, format: :json)
end
