json.array!(@scores) do |score|
  json.extract! score, :id, :playstyle, :difficulty, :score, :player_id, :music_id, :season_id
  json.url score_url(score, format: :json)
end
