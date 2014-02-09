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
    if music && music.machine
      if music.machine.playstyles.present?
        # for the machine which has some playstyles
        errors.add(:playstyle, ' is not valid') unless music.machine.valid_playstyle? playstyle
      else
        # for the machine which has no playstyles
        errors.add(:playstyle, ' must not be given') if playstyle.present?
      end
    end
  end

  def validate_difficulty
    if music && (!music.machine.valid_difficulty? difficulty)
      errors.add(:difficulty, 'is not valid')
    end
  end

  def self.get_top_scores(music, difficulty, playstyle: nil, num: 3)
    raise ArgumentError, "Music must be given" unless music
    raise ArgumentError, "Difficulty must be given" unless difficulty
    raise ArgumentError, "Playstyle must be given for this machine" if (music.machine.playstyles.present? && !playstyle.present?)
    raise ArgumentError, 'Playstyle must not be given for this machine' if (!music.machine.playstyles.present? && playstyle.present?)
    q = where(music: music, difficulty: difficulty)
    q = q.where(playstyle: playstyle) if playstyle.present?
    q = q.order(score: :desc, updated_at: :desc)
    q = q.limit(num) if num
    q
  end
end
