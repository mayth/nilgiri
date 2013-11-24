class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  serialize :playstyles, Array
  has_many :musics

  def valid_difficulty?(difficulty)
    difficulties.include? difficulty
  end
end
