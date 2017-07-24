class CreateRentingPhases < ActiveRecord::Migration[5.1]
  def change
    create_table :renting_phases do |t|
      t.date :start_date, null: false, comment: '开始日期'
      t.date :end_date, null: false, comment: '截止日期'
      t.integer :price, null: false, default: 0, comment: '月租金'
      t.integer :cycles, null: false, default: 1, comment: '几个月交一次租金'
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
