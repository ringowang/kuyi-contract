class RentingPhase < ApplicationRecord
  after_create :generate_invoices
  belongs_to :contract
  validate :start_date_must_before_than_end_date
  validate :date_must_in_contract_date
  validate :date_cannot_repeat

  has_many :invoices, dependent: :destroy

  def generate_invoices
    cycles_count = 0
    months_count = 0
    tem_date = start_date
    invoice_start_date = start_date
    left_days = end_date - start_date
    while tem_date + 1.month - 1.day <= end_date
      months_count += 1
      if months_count == cycles
        cycles_count += 1
        months_count = 0
        invoice_end_date = invoice_start_date + cycles.months - 1
        invoice = Invoice.create(start_date: invoice_start_date.to_time, end_date: invoice_end_date.to_time, due_date: (invoice_start_date.change(day: 15) - 1.month), total: cycles * price, renting_phase_id: self.id)
        invoice.generate_cycle_line_items
        invoice_start_date = invoice_end_date + 1.day
      end
      tem_date = tem_date + 1.month
      left_days = (end_date - tem_date).to_i + 1
    end
    left_days_price = months_count * price + left_days * price * 12 / 365.0
    invoice = Invoice.create(start_date: invoice_start_date, end_date: end_date, total: left_days_price, renting_phase_id: self.id, due_date: (invoice_start_date.change(day: 15) - 1.month)) if ( months_count > 0 || left_days > 0)
    invoice.generate_special_line_items(months: months_count,days: left_days )
  end

private

  def start_date_must_before_than_end_date
    if self.start_date.nil? || self.end_date.nil?
      errors.add(:base, '开始日期和截止日期不能为空')
    elsif self.start_date > self.end_date
      errors.add(:base, '开始日期不能早于截止日期')
    end
  end

  def date_must_in_contract_date
    if self.start_date < self.contract.start_date || self.end_date > self.contract.end_date
      errors.add(:base, '交租阶段的时间必须在合同内')
    end
  end

  def date_cannot_repeat
    if self.id.nil? && self.contract.renting_phases.where("start_date <= ? AND end_date >= ?", self.end_date, self.start_date).present?
      errors.add(:base, '时间不能有重叠')
    end
  end
end
