class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.all
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      begin
        @season = Season.friendly.find(params[:id])
      rescue
        @season = Season.find(params[:id])
      end
    end
end
