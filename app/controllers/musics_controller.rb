class MusicsController < ApplicationController
  before_action :set_music, only: [:show]

  # GET /musics
  # GET /musics.json
  # GET /machines/machine_id/musics
  # GET /machines/machine_id/musics.json
  def index
    if params[:machine_id]
      begin
        machine = Machine.friendly.find(params[:machine_id])
      rescue
        machine = Machine.find(params[:machine_id])
      end
      @musics = machine.musics
      if params[:season_id].present?
        begin
          season = Season.friendly.find(params[:season_id])
        rescue
          season = Season.find(params[:season_id])
        end
        @musics = @musics.where(season: season)
      end
    else
      @musics = Music.all
    end
  end

  # GET /musics/1
  # GET /musics/1.json
  # GET /machines/machine_id/musics/1
  # GET /machines/machine_id/musics/1.json
  def show
    @scores = @music.machine.get_top_scores(@music.season, num: nil)[@music]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      if params[:machine_id]
        begin
          machine = Machine.friendly.find(params[:machine_id])
        rescue
          machine = Machine.find(params[:machine_id])
        end
        @music = machine.musics.find(params[:id])
      else
        @music = Music.find(params[:id])
      end
    end
end
