class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :music
  belongs_to :season

  validate :validate_playstyle
  validate :validate_difficulty
  validates :score, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player, presence: true
  validates :music, presence: true
  validates :season, presence: true

  def validate_playstyle
    if music &&
      music.machine &&
      music.machine.playstyles &&
      (!music.machine.valid_playstyle? playstyle)
      errors.add(:playstyle, 'is not valid')
    end
  end

  def validate_difficulty
    if music && (!music.machine.valid_difficulty? difficulty)
      errors.add(:difficulty, 'is not valid')
    end
  end
end
