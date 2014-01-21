class Machine < ActiveRecord::Base
  has_many :musics

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

  def musics_for(season = nil)
    season = Season.for(:now) unless season
    musics.where(season: season).order(:id) if season
  end
end
