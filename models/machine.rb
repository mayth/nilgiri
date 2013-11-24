class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  serialize :playstyles, Array
  has_many :musics

  def valid_difficulty?(difficulty)
    difficulties.include? difficulty
  end

  def valid_playstyle?(playstyle)
    playstyles && playstyles.any? && playstyles.include?(playstyle)
  end
end
