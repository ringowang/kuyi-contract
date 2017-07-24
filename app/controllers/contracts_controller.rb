class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :destroy]

  # GET /contracts
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  def show
    @renting_phases = @contract.renting_phases
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # POST /contracts
  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      redirect_to @contract, notice: 'Contract was successfully created.'
    else
      render :new
    end
  end

  # DELETE /contracts/1
  def destroy
    @contract.destroy
    redirect_to contracts_url, notice: 'Contract was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contract_params
      params.require(:contract).permit(:title, :start_date, :end_date)
    end
end
