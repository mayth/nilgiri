require 'scrypt'

class Player < ActiveRecord::Base
  has_many :scores

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  def screen_name
    s = self[:screen_name]
    (s && !s.empty?) ? s : self[:name]
  end

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

  def password=(pw)
    if pw && !pw.empty?
      self[:password] = SCrypt::Password.create(pw)
    else
      self[:password] = nil
    end
  end

  def password
    self[:password] && SCrypt::Password.new(self[:password])
  end

  def self.authorize(name, pass)
    p = self.find_by_name(name)
    p && p.password == pass
  end
end
