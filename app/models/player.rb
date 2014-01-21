require 'scrypt'

class Player < ActiveRecord::Base
  has_many :scores

  validates :name, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :password, presence: true

  def screen_name
    self[:screen_name].presence || self[:name]
  end

  def password=(pw)
    self[:password] = pw.present? ?
      SCrypt::Password.create(pw) :
      nil
  end

  def password
    self[:password] && SCrypt::Password.new(self[:password])
  end

  def register_score(season: nil, music: nil, difficulty: nil, score: nil, playstyle: nil)
    [season, music, difficulty, score].each do |v|
      raise ArgumentError unless v
    end
    q = Score.where(player: self, season: season, music: music, difficulty: difficulty)
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

  def self.authorize(name, pass)
    p = self.find_by(name: name)
    if p && p.password == pass
      p
    else
      nil
    end
  end
end
