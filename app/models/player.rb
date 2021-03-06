require 'scrypt'

class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable
  has_many :scores

  validates :name, presence: true

  def register_score(season: nil, music: nil, difficulty: nil, score: nil, playstyle: nil)
    [season, music, difficulty, score].each do |v|
      raise ArgumentError unless v
    end
    q = scores.where(season: season, music: music, difficulty: difficulty)
    q = q.where(playstyle: playstyle) if playstyle
    s = q.first
    if s
      s.score = score if s.score < score
    else
      s = self.scores.build(
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
