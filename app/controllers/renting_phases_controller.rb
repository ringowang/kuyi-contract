class RentingPhasesController < ApplicationController
  before_action :set_renting_phase, only: [:show, :edit, :update, :destroy]

  # GET /renting_phases
  def index
    @renting_phases = RentingPhase.all
  end

  # GET /renting_phases/1
  def show
  end

  # GET /renting_phases/new
  def new
    @renting_phase = RentingPhase.new
  end

  # GET /renting_phases/1/edit
  def edit
  end

  # POST /renting_phases
  def create
    @renting_phase = RentingPhase.new(renting_phase_params)

    if @renting_phase.save
      redirect_to @renting_phase, notice: 'Renting phase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /renting_phases/1
  def update
    if @renting_phase.update(renting_phase_params)
      redirect_to @renting_phase, notice: 'Renting phase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /renting_phases/1
  def destroy
    @renting_phase.destroy
    redirect_to renting_phases_url, notice: 'Renting phase was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renting_phase
      @renting_phase = RentingPhase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def renting_phase_params
      params.require(:renting_phase).permit(:start_date, :end_date, :price, :cycles, :contract_id)
    end
end
