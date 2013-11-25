class ScoreValidator < ActiveModel::Validator
  def validate(record)
    # presence of season
    unless record.season && !record.season.empty?
      record.errors[:season] << "can't be empty."
    end
    # presence of music
    unless record.music
      record.errors[:music] << 'A score must be associated with a music.'
    end
    # presence of player
    unless record.player
      record.errors[:player] << 'A score must be associated with a player.'
    end
    # difficulty validation
    unless record.difficulty && !record.difficulty.empty?
      record.errors[:difficulty] << 'is required.'
    else
      if record.music && !record.music.machine.valid_difficulty?(record.difficulty)
        record.errors[:difficulty] << 'is not valid.'
      end
    end
    # playstyle validation
    if record.music && record.music.machine && record.music.machine.playstyles
      unless record.music.machine.valid_playstyle? record.playstyle
        record.errors[:playstyle] << 'is not valid.'
      end
    end
    # score validation
    unless record.score
      record.errors[:score] << "can't be empty."
    else
      unless record.score >= 0
        record.errors[:score] << 'must be greater than or equal to 0.'
      end
    end
  end
end

class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :music

  validates_with ScoreValidator
end
