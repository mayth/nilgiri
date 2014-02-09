class MachinesController < ApplicationController
  before_action :set_machine, only: [:show]

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @musics = @machine.musics_for(@current_season)
    @ranking = @machine.get_top_scores(@current_season, num: nil)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      begin
        @machine = Machine.friendly.find(params[:id])
      rescue
        @machine = Machine.find(params[:id])
      end
    end
end
