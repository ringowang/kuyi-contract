class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.date :start_date, null: false, comment: '开始日期'
      t.date :end_date, null: false, comment: '截止日期'
      t.integer :unit_price, null: false, default: 0, comment: '单价: 月租金或日租金'
      t.integer :units, null: false, default: 0, comment: '月数或天数'
      t.integer :total, null: false, default: 0, comment: '总费用'
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
