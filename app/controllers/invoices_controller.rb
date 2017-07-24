class InvoicesController < ApplicationController

  # GET /invoices/1
  def show
    @contract = Contract.find(params[:contract_id])
    @renting_phase = @contract.renting_phases.find(params[:renting_phase_id])
    @invoice = @renting_phase.invoices.find(params[:id])
    @line_items = @invoice.line_items
  end
end
