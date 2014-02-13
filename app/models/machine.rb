class Machine < ActiveRecord::Base
  has_many :musics

  extend FriendlyId
  friendly_id :name, use: :slugged

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

  def get_top_scores(season = nil, num: 3)
    musics = musics_for(season)
    Hash[musics.map {|music|
      [music, get_top_scores_for_music(music, num)]
    }]
  end

  private
  def get_top_scores_for_music(music, num)
    if playstyles.present?
      Hash[playstyles.map {|style|
        [style, get_top_scores_for_each_difficulty(music, style, num: num)]
      }]
    else
      get_top_scores_for_each_difficulty(music, num: num)
    end
  end

  def get_top_scores_for_each_difficulty(music, playstyle = nil, num: 3)
    Hash[difficulties.map {|difficulty|
        [difficulty, Score.get_top_scores(music, difficulty, playstyle: playstyle, num: 3)]
    }]
  end
end
