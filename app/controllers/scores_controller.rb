class ScoresController < ApplicationController
  before_filter :authenticate_player!, except: [:index]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.where(season: @current_season).order(updated_at: :desc)
  end

  # GET /scores/new
  def new
    @page_id = 'score_new'
    @score = Score.new
  end

  # POST /scores
  # POST /scores.json
  def create
    p = score_params
    season = @current_season
    music = Music.find(p[:music_id])
    difficulty = p[:difficulty]
    score = p[:score].to_i
    playstyle = p[:playstyle].presence

    @score = current_player.register_score(
      season: season, music: music,
      difficulty: difficulty, playstyle: playstyle,
      score: score)

    respond_to do |format|
      if @score.save
        format.html { redirect_to machine_path(@score.music.machine), success: 'Score was successfully created.' }
        format.json { render action: 'index', status: :created, location: @score }
      else
        @page_id = 'score_new'
        format.html { render action: 'new' }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:playstyle, :difficulty, :score, :player_id, :music_id, :season_id)
    end
end
