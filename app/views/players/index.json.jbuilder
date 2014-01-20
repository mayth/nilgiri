json.array!(@players) do |player|
  json.extract! player, :id, :name, :screen_name, :password, :twitter_id
  json.url player_url(player, format: :json)
end
