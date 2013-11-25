class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  serialize :playstyles, Array
  has_many :musics

  validates :name, presence: true
  validates :difficulties, presence: true

  def valid_difficulty?(difficulty)
    difficulties.include? difficulty
  end

  def valid_playstyle?(playstyle)
    if playstyles && playstyles.any?
      playstyles.include?(playstyle)
    else
      !playstyle || playstyle.empty?
    end
  end
end
