class RentingPhasesController < ApplicationController
  before_action :set_contract, only: [:show, :destroy, :new, :create]
  before_action :set_renting_phase, only: [:show, :destroy]

  # GET /renting_phases/1
  def show
    @invoices = @renting_phase.invoices
  end

  # GET /renting_phases/new
  def new
    @renting_phase = RentingPhase.new
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date
  end

  # POST /renting_phases
  def create
    @renting_phase = RentingPhase.new(renting_phase_params)
    @renting_phase.contract = @contract
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date

    if @renting_phase.save
      redirect_to contract_path(@contract), notice: 'Renting phase was successfully created.'
    else
      render :new
    end
  end

  # DELETE /renting_phases/1
  def destroy
    @renting_phase.destroy
    redirect_to contract_url(@contract), notice: 'Renting phase was successfully destroyed.'
  end

  private

    def set_contract
      @contract = Contract.find(params[:contract_id])
    end

    def set_renting_phase
      @contract = Contract.find(params[:contract_id])
      @renting_phase = @contract.renting_phases.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def renting_phase_params
      params.require(:renting_phase).permit(:start_date, :end_date, :price, :cycles, :contract_id)
    end
end
