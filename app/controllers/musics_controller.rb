class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :edit, :update, :destroy]

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
    else
      @musics = Music.all
    end
  end

  # GET /musics/1
  # GET /musics/1.json
  # GET /machines/machine_id/musics/1
  # GET /machines/machine_id/musics/1.json
  def show
  end

  # GET /musics/new
  def new
    @music = Music.new
  end

  # GET /musics/1/edit
  def edit
  end

  # POST /musics
  # POST /musics.json
  def create
    @music = Music.new(music_params)

    respond_to do |format|
      if @music.save
        format.html { redirect_to @music, notice: 'Music was successfully created.' }
        format.json { render action: 'show', status: :created, location: @music }
      else
        format.html { render action: 'new' }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /musics/1
  # PATCH/PUT /musics/1.json
  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to @music, notice: 'Music was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music.destroy
    respond_to do |format|
      format.html { redirect_to musics_url }
      format.json { head :no_content }
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_params
      params.require(:music).permit(:name, :artist, :machine_id, :season_id)
    end
end
