class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  serialize :playstyles, Array

  def valid_difficulty?(difficulty)
    difficulties.include? difficulty
  end

  def valid_playstyle?(playstyle)
    if playstyles.present?
      playstyles.include? playstyle
    else
      playstyle.blank?
    end
  end
end
