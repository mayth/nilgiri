class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  serialize :playstyles, Array
  has_many :musics

  validates :name, presence: true
  validates :difficulties, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

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

  def musics_for(season = nil)
    season = Season.for(:now) unless season
    musics.where(season_id: season.id).order(:id)
  end
end
