class ScoresController < ApplicationController
  before_filter :authenticate_player!, except: [:index]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/new
  def new
    @page_id = 'score_new'
    @score = Score.new
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to action: 'index', status: :created, notice: 'Score was successfully created.' }
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
