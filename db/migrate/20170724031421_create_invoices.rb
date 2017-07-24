class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.date :start_date, null: false, comment: '开始日期'
      t.date :end_date, null: false, comment: '截止日期'
      t.date :due_date, null: false, comment: '交租日期'
      t.integer :total, null: false, default: 0, comment: '一共多少钱'
      t.references :renting_phase, foreign_key: true

      t.timestamps
    end
  end
end
