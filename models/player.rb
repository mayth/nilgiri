class Player < ActiveRecord::Base
  has_many :scores

  def register_score(season, music, difficulty, score, playstyle = nil)
    s = Score.where(player_id: id, season: season, music_id: music.id, difficulty: difficulty, playstyle: playstyle).first
    if s
      if s.score < score
        s.score = score
        s.save!
      end
    else
      s = self.scores.create(
        season: season,
        music: music,
        difficulty: difficulty,
        playstyle: playstyle,
        score: score
      )
    end
    s
  end
end
