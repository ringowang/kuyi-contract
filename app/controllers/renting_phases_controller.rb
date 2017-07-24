class RentingPhasesController < ApplicationController

  # GET /renting_phases
  def index
    @contract = Contract.find(params[:contract_id])
    @renting_phases = @contract.renting_phases
  end

  # GET /renting_phases/1
  def show
  end

  # GET /renting_phases/new
  def new
    @contract = Contract.find(params[:contract_id])
    @renting_phase = RentingPhase.new
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date
  end

  # GET /renting_phases/1/edit
  def edit
    @contract = Contract.find(params[:contract_id])
    @renting_phase = @contract.renting_phases.find(params[:id])
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date
  end

  # POST /renting_phases
  def create
    @contract = Contract.find(params[:contract_id])
    @renting_phase = RentingPhase.new(renting_phase_params)
    @renting_phase.contract = @contract
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date

    if @renting_phase.save
      redirect_to contract_path(@contract), notice: 'Renting phase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /renting_phases/1
  def update
    @contract = Contract.find(params[:contract_id])
    @renting_phase = @contract.renting_phases.find(params[:id])
    @point_time = @contract.renting_phases.present? ? @contract.renting_phases.last.end_date + 1.day : @contract.start_date
    if @renting_phase.update(renting_phase_params)
      redirect_to contract_path(@contract), notice: 'Renting phase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /renting_phases/1
  def destroy
    @contract = Contract.find(params[:contract_id])
    @renting_phase = @contract.renting_phases.find(params[:id])
    @renting_phase.destroy
    redirect_to contract_url(@contract), notice: 'Renting phase was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def renting_phase_params
      params.require(:renting_phase).permit(:start_date, :end_date, :price, :cycles, :contract_id)
    end
end
