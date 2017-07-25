class LineItem < ApplicationRecord
  belongs_to :invoice
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total, presence: true
  validates :units, presence: true
  validates :unit_price, presence: true
end
