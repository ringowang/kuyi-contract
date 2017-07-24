class Invoice < ApplicationRecord
  belongs_to :renting_phase
  has_many :line_items, dependent: :destroy

  def generate_cycle_line_items
    renting_phase = self.renting_phase
    LineItem.create(start_date: start_date, end_date: end_date, total: total, unit_price: renting_phase.price, units: renting_phase.cycles, invoice_id: self.id )
  end

  def generate_special_line_items(opt = {})
    renting_phase = self.renting_phase
    left_months = opt[:months]
    left_days = opt[:days]
    if left_months > 0
      LineItem.create(start_date: start_date, end_date: (start_date + left_months.months), total: left_months * renting_phase.price , unit_price: renting_phase.price, units: left_months, invoice_id: self.id )
    end

    if left_days > 0
      day_price = renting_phase.price * 12 / 365.0
      left_day_start_date = end_date - left_days.days
      LineItem.create(start_date: left_day_start_date, end_date: end_date, total: day_price * left_days , unit_price: day_price, units: left_days, invoice_id: self.id )
    end
  end
end
