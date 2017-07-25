class Contract < ApplicationRecord
  has_many :renting_phases, dependent: :destroy
  validate :start_date_must_before_than_end_date
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :title, presence: true

  def start_date_must_before_than_end_date
    if self.start_date.nil? || self.end_date.nil?
      errors.add(:base, '开始日期和截止日期不能为空')
    elsif self.start_date > self.end_date
      errors.add(:base, '开始日期不能早于截止日期;')
    end
  end
end
