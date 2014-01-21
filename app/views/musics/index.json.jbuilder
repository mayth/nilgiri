json.array!(@musics) do |music|
  json.extract! music, :id, :name, :artist, :machine_id, :season_id
  json.url music_url(music, format: :json)
end
